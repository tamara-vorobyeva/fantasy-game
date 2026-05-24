# 📊 Analysis of Player Monetization and In-Game Economy Optimization for the "Secrets of the Darkwood" Project

## 📌 Business Case Overview
The client requires a comprehensive analysis of the commercial health and player monetization patterns within the RPG "Secrets of the Darkwood". The final insights will be utilized to optimize marketing and product management strategy.

## 🎯 Project Objectives 
- **Assess Conversion Dynamics**: Measure the overall baseline of paying users across the game and determine thу precise impact of various character races on transaction conversion rates.📌 
- **Identify Revenue Structure**: Conduct a Pareto analysis to measure revenue concentration.📌 
- **Deliver Strategic Insights**: Provide recommendations for catalog restructuring and segment-targeted marketing activities based on player behavioral insights.📌

## 🔗 Quick Links
* **[View SQL Data Cleaning & Analysis Script](src/data-cleansing-analysis)**
* **[Dataset](data/dataset-500)**

---

## 🛠 Tech Stack
* **Database**: PostgreSQL utilized to isolate anomalous transactions and duplicates, to execute advanced analytical queries, complex aggregations, window functions, and data segmentation.
* **Data Processing Interface**: PostgreSQL via DBeaver served as the primary database client environment for handling table connections and script restoration.

---

## 🔍 Research Approach 
Based on the comprehensive dataset this analysis evaluates how character demographics, specifically character races, impact player conversion and the purchasing dynamics of the premium currency.
* **Data Cleaning & Scope**: The study analyzed a cleaned 2015–2018 real estate dataset for St. Petersburg and Leningrad Oblast towns, filtering out extreme anomalies in area, price, and zero-duration listings to ensure consistency.
* **Methodological Segmentation**: The analysis separated the data into specific temporary subsets to distinctly track listing publications (supply) and listing removals (completed sales) over time.
* **Time Lag Integration**: The methodology explicitly incorporated a natural 1–2 month transaction lag, noting that listing removals heavily reflect purchasing decisions made in preceding months.  

---

## 💡 Key Findings
*	**St. Petersburg Domination**: St. Petersburg heavily drives the regional market, exhibiting 1.7x higher square-meter prices and a financial volume in November that is 8 times larger than the entire Leningrad Oblast. 
*	**Autumn Market Peak**: Autumn (September to November) serves as the ultimate peak season where buyer and seller activities align, contrasted by a sharp supply-demand mismatch in February and absolute market stagnation in May. 
*	**Liquidity and Format Correlations**: Most listings close within 1–3 months or stretch beyond half a year, with transaction speeds heavily dictated by lower prices, smaller 1-room formats, and the presence of a balcony. 

---

## 🚀 Strategic Recommendations
*	**Core Focus & Timing**: Concentrate primary business operations within St. Petersburg and launch major marketing campaigns between late September and October to capture the peak annual demand. 
*	**Target High-Liquidity Segment**: Build the core portfolio around 1–2 room apartments ranging between 45 and 65 sq.m. in St. Petersburg and highly accessible inner-city towns like Gatchina, Pushkin, and Pavlovsk. 
*	**Cautious Premium Execution**: Enter the high-commission premium tier selectively, factoring in aggressive market competition and a 1.5x longer sales cycle (averaging 228 days compared to 155 days for budget properties). 

---

## 📁 Repository Structure
* 'README.md' — Project overview and executive summary (this file).
* '/data' — Anonymized raw dataset limited to 500 data entries.
* '/src' — Source code folder containing SQL script (PostGreSQL).
