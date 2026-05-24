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
* **Data Cleaning & Scope**: The study analyzed a transactional dataset containing over 1.3 million records. A rigorous data cleansing protocol was recommended to address 508,000 missing seller_id entries (approx. 40% of the database) and isolate extreme outliers.
* **Statistical Anomaly Filtering**: Established an explicit transaction cut-off threshold using the formula $\text{Mean} + \text{1 Standard Deviation} = 3043.04$ credits to isolate 44,043 outlier records (3.37% of the dataset) from typical consumer metrics.  
* **Behavioral and Segment Cohorts**: Players were grouped dynamically into analytical subsets based on character race (race_id) and total purchase value to distinctly evaluate purchasing frequency against average check sizes.  

---

## 💡 Key Findings 
* **Severe Revenue Concentration (Pareto Risk)**: The in-game economy relies heavily on a small group of "whales"; a mere 11.7% of users (2,590 players) generate 80% of total revenue, with a single outlier account (08-8623692) generating 28.47 million credits alone.
* **Monopoly of Core Epic Items**: Out of 182 catalog items, just two items account for 98% of total revenue: "Book of Legends" (76.87% value share, bought by 88.41% of players) and "Bag of Holding" (20.81% value share).
* **Race-Driven Spending Patterns**: Character races dictate clear player behavior; Demons yield the highest conversion rate (19.95%), Northmen lead the premium tier with a 15–20% higher average check size (761.52 credits), while Humans generate the highest purchase frequency (121.4 purchases) but the lowest average check size.
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
