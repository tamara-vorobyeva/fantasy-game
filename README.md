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
* **Database**: To analyze the game economy of "Darkwood", a relational database consisting of 6 tables was used: 'users', 'events', 'items', 'classes', 'skills', 'race', and 'country'.
* **Data filtration**: PostgreSQL utilized to isolate anomalous transactions and duplicates, to execute advanced analytical queries, complex aggregations, window functions, and data segmentation.
* **Data Processing Interface**: PostgreSQL via DBeaver served as the primary database client environment for handling table connections and script restoration.
### Analytical Data Mart
Since the source tables are highly normalized, a denormalized analytical data mart was designed for ad-hoc querying and final visualization. This data mart consolidates raw transaction logs with user profiles and calculates key business metrics (such as purchase frequency and LTV) at the individual player level.

**Sample view of the resulting data mart (Top 5 players by total spend):
|user_id|registration_date|character_race|character_class|country|is_payer|total_transactions|total_spend_amount|
|-------|-----------------|--------------|---------------|-------|--------|------------------|------------------|
|08-8623692|10/2/2018|Northman|Knight|United States|1|596|28474180|
|77-1992679|6/22/2004|Human|Shaman|United States|0|13552|6557477.5|
|42-7020868|3/13/2009|Hobbit|Knight|United States|0|4504|6388133.0|
|48-0839790|9/28/2011|Elf|Healer|United States|0|444|5542913.0|
|31-2080898|8/30/2019|Angel|Knight|United States|0|670|4269111.5|
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
* **Segment-Targeted Marketing**: Deploy high-value "Hero Packs" and VIP tiers to maximum-spend Northmen and Elves; raise entry-level item prices for high-frequency Humans and Angels; and implement instant retargeting or subscription offers for high-conversion Demons.
* **Product Catalog Optimization**: Systematically audit and remove or replace the 180 non-performing items that make up just 2% of sales, introduce new high-value "star" items, and explore external luxury brand cosmetic collaborations.
* **Data Architecture & Analytics To-Do's**: Run an intensive database cleaning cycle to address the 508,000 transactions (40% of the base) missing a valid seller_id, and conduct analysis of the top 10 whale profiles separately from baseline financial forecast.

---

## 📁 Repository Structure
* 'README.md' — Project overview and executive summary (this file).
* '/data' — Anonymized raw dataset limited to 500 data entries.
* '/src' — Source code folder containing SQL script (PostGreSQL).
