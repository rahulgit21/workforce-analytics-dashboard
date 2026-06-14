import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load Dataset
df = pd.read_csv(r"C:\Employee Attrition Prediction Dataset\dataset csv\employee_attrition_dataset_10000.csv")

# Remove Extra Spaces from Column Names
df.columns = df.columns.str.strip()

# DATA QUALITY CHECKS
# =========================

print("Dataset Shape:")
print(df.shape)

print("\nColumn Names:")
print(df.columns.tolist())

print("\nDataset Info:")
print(df.info())

print("\nMissing Values:")
print(df.isnull().sum())

print("\nDuplicate Rows:")
print(df.duplicated().sum())

print("\nSummary Statistics:")
print(df.describe())

# =====================================================
# ATTRITION OVERVIEW
# =====================================================

print("\nAttrition Distribution:")
print(df["Attrition"].value_counts())

sns.countplot(data=df, x="Attrition")
plt.title("Employee Attrition Distribution")
plt.show()

# =====================================================
# DEPARTMENT ATTRITION ANALYSIS
# =====================================================

sns.countplot(data=df, x="Department", hue="Attrition")
plt.xticks(rotation=45)
plt.title("Attrition by Department")
plt.show()

# =====================================================
# OVERTIME ANALYSIS
# =====================================================

sns.countplot(data=df, x="Overtime", hue="Attrition")
plt.title("Overtime Impact on Attrition")
plt.show()

# =====================================================
# JOB SATISFACTION ANALYSIS
# =====================================================

sns.countplot(data=df, x="Job_Satisfaction", hue="Attrition")
plt.title("Job Satisfaction vs Attrition")
plt.show()

# =====================================================
# WORK LIFE BALANCE ANALYSIS
# =====================================================

sns.countplot(data=df, x="Work_Life_Balance", hue="Attrition")
plt.title("Work Life Balance vs Attrition")
plt.show()

# =====================================================
# MONTHLY INCOME DISTRIBUTION
# =====================================================

plt.figure(figsize=(8,5))
sns.histplot(df["Monthly_Income"], bins=30)
plt.title("Monthly Income Distribution")
plt.show()

# =====================================================
# INCOME VS ATTRITION
# =====================================================

sns.boxplot(data=df, x="Attrition", y="Monthly_Income")
plt.title("Income vs Attrition")
plt.show()

# =====================================================
# PROMOTION IMPACT ANALYSIS
# =====================================================

sns.boxplot(data=df, x="Attrition", y="Years_Since_Last_Promotion")
plt.title("Promotion Delay vs Attrition")
plt.show()

# =====================================================
# ABSENTEEISM ANALYSIS
# =====================================================

sns.boxplot(data=df, x="Attrition", y="Absenteeism")
plt.title("Absenteeism vs Attrition")
plt.show()

# =====================================================
# PROJECT COUNT ANALYSIS
# =====================================================

sns.histplot(df["Project_Count"], bins=15)
plt.title("Project Count Distribution")
plt.show()

# =====================================================
# TRAINING HOURS ANALYSIS
# =====================================================

sns.histplot(df["Training_Hours_Last_Year"], bins=20)
plt.title("Training Hours Distribution")
plt.show()

# =====================================================
# CORRELATION HEATMAP
# =====================================================

numeric_df = df.select_dtypes(include=np.number)

plt.figure(figsize=(14,10))
sns.heatmap(numeric_df.corr(), cmap="Blues")
plt.title("Correlation Heatmap")
plt.show()

# =====================================================
# BUSINESS INSIGHTS
# =====================================================

print("""
KEY BUSINESS INSIGHTS

1. Workforce attrition rate is approximately 20%.

2. Employees working overtime show higher turnover risk.

3. Lower job satisfaction is associated with higher attrition.

4. Poor work-life balance contributes to employee exits.

5. Promotion delays increase workforce risk.

6. Certain departments experience higher attrition than others.

7. Higher absenteeism is linked to employee turnover.

8. Employee engagement and career development programs can improve retention.
""")
