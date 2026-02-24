import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings 
warnings.filterwarnings('ignore')

#Load dataset 

df = pd.read_csv('IPL2025Batters.csv')

print("="*55)
print("DATASET OVERVIEW")
print("="*55)
print(f"Shape   : {df.shape[0]} rows * {df.shape[1]} columns")
print(f"Columns : {list(df.columns)}")
print()
print(df.head())

#Data cleaning & Preprocessing

print("\n" + "="*55)
print("DATA CLEANING")
print("="*55)

#Check missing values
print("\nMissing Values:")
print(df.isnull().sum())

#Drop rows where Runs or Matches is missing
df.dropna(subset=['Runs', 'Matches'], inplace=True)

#Convert numeric columns (in case they are read as strings)
numeric_cols = ['Runs', 'Matches', 'Inn', 'No', 'HS', 'AVG', 'BF', 'SR', '100s', '50s', '4s', '6s']
for col in numeric_cols:
    df[col] = pd.to_numeric(df[col], errors='coerce')

df.dropna(subset=numeric_cols, inplace=True)

#Feature Engineering
df['Boundary_Runs'] = (df['4s']*4) + (df['6s'] * 6)
df['Boundary_Pct'] = ((df['Boundary_Runs']/df['Runs'])*100).round(2)
df['Avg_Runs_Per_Match'] = (df['Runs']/df['Matches']).round(2)

print('\nAfter Cleaning Shape:', df.shape)
print('\nBasic Statistics:')
print(df[numeric_cols].describe().round(2))

#Plot Settings

sns.set_theme(style='darkgrid', palette='muted', font_scale=1.1)
SAVE_DPI =150

#CHART 1 : HEATMAP - Correlation between numeric features

print('\nGenerting Chart 1 : Heatmap...')
corr_cols = ['Runs', 'Matches', 'Inn', 'AVG', 'BF', 'SR', '100s', '50s', '4s', '6s',
            'Boundary_Pct', 'Avg_Runs_Per_Match']
corr_matrix = df[corr_cols].corr()
fig, ax = plt.subplots(figsize=(17, 9))
mask = np.triu(np.ones_like(corr_matrix, dtype=bool))

sns.heatmap(
    corr_matrix,
    mask = mask,
    annot = True,
    fmt = '.2f',
    cmap = 'coolwarm',
    center=0,
    linewidths= 0.5,
    linecolor= 'white',
    square = True,
    cbar_kws= {'shrink':0.8, 'label': 'Correlation'},
    ax = ax
)

ax.set_title("IPL Batting Stats - Features Correlation Heatmap", fontsize=15, fontweight='bold', pad=15)
plt.xticks(rotation=45, ha='right')
plt.yticks(rotation=0)
plt.tight_layout()
plt.savefig('Chart1_heatmap.png', dpi=SAVE_DPI, bbox_inches='tight')
plt.show()
print("Heatmap saved as chart1_heatmap.png")

#Chart 2 - Pairplot : Key batting Metrics

print('\nGenerating Chart 2 : Pairplot...')

#Top 5 teams by player count 
top_teams = df['Team'].value_counts().head(5).index.tolist()
df_top = df[df['Team'].isin(top_teams)].copy()

pair_cols = ['Runs', 'AVG', 'SR', '6s', 'Boundary_Pct']
g = sns.pairplot(
    df_top[pair_cols + ['Team']],
    hue = 'Team',
    palette= 'Set2',
    corner=True,
    diag_kind='kde',
    plot_kws={'alpha': 0.6, 's':40},
    diag_kws={'fill': True, 'alpha': 0.4}    
)

g.figure.suptitle('IPL Batting - Pairplot (Top 5 Teams)',
                  y=1.02, fontsize=14, fontweight='bold')
g.figure.savefig('chart2_pairplot.png', dpi=SAVE_DPI, bbox_inches='tight')
plt.show()
print('Pairplot saved as chart2_pairplot.png')

#Chart 3 : Boxplot : Runs & Avg by Team

print("\nGenerating Chart 3 : Boxpoot......")

#Team sorted my median runs
team_order = (df[df['Team'].isin(top_teams)]
              .groupby('Team')['Runs']
              .median()
              .sort_values(ascending=False)
              .index.tolist())

fig, axes = plt.subplots(1,2,figsize=(17, 7))

#Left: Runs per team
sns.boxplot(
    data=df[df['Team'].isin(top_teams)],
    x='Runs', y='Team',
    order=team_order,
    palette='Set3',
    width=0.6,
    flierprops=dict(marker='o', color='red', markersize=4),
    ax = axes[0]
)
axes[0].set_title('Total Runs Distribution by Team', fontsize=13, fontweight='bold')
axes[0].set_xlabel('Total Runs', fontsize=11)
axes[0].set_ylabel('Team', fontsize=11)

#Right: Batting Average per team
sns.boxplot(
    data=df[df['Team'].isin(top_teams)],
    x='AVG', y='Team',
    order=team_order,
    palette='pastel',
    width=0.6,
    flierprops=dict(marker='o', color='orange', markersize=4),
    ax = axes[1]
)

axes[1].set_title('Batting Average Distribution by Team', fontsize=13, fontweight='bold')
axes[1].set_xlabel('Batting Average', fontsize=11)
axes[1].set_ylabel('')

fig.suptitle("IPL Boxplot Analysis - Runs & Batting Average", 
             fontsize=15, fontweight='bold', y=1.02)
plt.tight_layout()
plt.savefig('chart3_boxplot.png', dpi=SAVE_DPI, bbox_inches='tight')
plt.show()
print('Boxplot saved as chart3_boxplot.png')

#Chart 4 - Violin Plot : Strike Rate & Boundary %

print("\nGenerating Chart 4 : Violin Plot...")

fig, axes = plt.subplots(1,2, figsize=(17, 7))

#Left : Strike Rate

sns.violinplot(
    data=df[df['Team'].isin(top_teams)],
    x='Team', y='SR',
    order=team_order,
    palette='husl',
    inner='box',
    ax = axes[0]
)
axes[0].set_title('Strike Rate Distribution by Team', fontsize=13, fontweight='bold')
axes[0].set_xlabel('')
axes[0].set_ylabel('Strike Rate', fontsize=11)
axes[0].tick_params(axis='x', rotation=30)

#Right : Boundary%

sns.violinplot(
    data=df[df['Team'].isin(top_teams)],
    x='Team', y='Boundary_Pct',
    order=team_order,
    palette='coolwarm',
    inner='quartile',
    ax=axes[1]
)
axes[1].set_title('Boundary % Distribution by Team', fontsize=13, fontweight='bold')
axes[1].set_xlabel('')
axes[1].set_ylabel('Boundary % of Total Runs', fontsize=11)
axes[1].tick_params(axis='x', rotation=30)

fig.suptitle("IPL Violin Plot - Strike Rate & Boundary Contribution",
             fontsize=15, fontweight='bold', y=1.02)
plt.tight_layout()
plt.savefig('Chart4_violin.png', dpi=SAVE_DPI, bbox_inches='tight')
plt.show()
print('Violin Plot saved as chart4_violin.png')

#Chart 5 - Bonus : Top 10 Run Scorers...

print("\nGenerating Chart 5 : Top 10 Run Scorers...")
top10 = df.nlargest(10, 'Runs')[['Player Name', 'Team', 'Runs', 'AVG', 'SR']].reset_index(drop=True)

fig, ax = plt.subplots(figsize=(13, 6))
bars = sns.barplot(
    data=top10,
    x='Runs', y='Player Name',
    palette='flare',
    ax=ax
)

#Add run values inside bars
for i, (val, avg, sr) in enumerate(zip(top10['Runs'], top10['AVG'],
                                       top10['SR'])):
    ax.text(val + 20, i, f"{val} | Avg:{avg} | SR:{sr}",
            va='center', fontsize=9, color='white' if val > 400 else 'black')
    
ax.set_title("IPL Top 10 Run Scorers", fontsize=15, fontweight='bold', pad=15)
ax.set_xlabel('Total Runs', fontsize=12)
ax.set_ylabel('Player', fontsize=12)
plt.tight_layout()
plt.savefig("Chart5_top10_scorers.png", dpi=SAVE_DPI, bbox_inches='tight')
plt.show()
print("Top 10 Chart saved as chart5_top10_scorers.png")

#Key Insights

print("\n" + "="*55)
print("KEY INSIGHTS FROM EDA")
print("="*55)

print(f"\nTop Run Scorer : {df.loc[df['Runs'].idxmax(), 'Player Name']} ({int(df['Runs'].max())} runs)")
print(f"Best Strike Rate : {df.loc[df['SR'].idxmax(), 'Player Name']} (SR: {df['SR'].max()})")
print(f"Best Average : {df.loc[df['AVG'].idxmax(), 'Player Name']} (Avg: {df['AVG'].max()})")
print(f"Most Sixes : {df.loc[df['6s'].idxmax(), 'Player Name']} ({int(df['6s'].max())} sixes)")
print(f"Most 100s : {df.loc[df['100s'].idxmax(), 'Player Name']} ({int(df['100s'].max())} centuries)")

print(f"\nOverall Avg Strike Rate : {df['SR'].mean():.2f}")
print(f"Overall Batting Avg : {df['AVG'].mean():.2f}")
print(f"Total Players Analyzed : {df.shape[0]}")
print(f"Total Teams : {df['Team'].nunique()}")

print("\nEDA Complete All charts saved.")
