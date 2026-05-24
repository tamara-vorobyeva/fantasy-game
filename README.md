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
* **Statistical Anomaly Thresholding**: Anomaly detection was established using a strict statistical boundary formula:$$\text{Threshold} = \mu (\text{avg\_amount}) + \sigma (\text{stdev}) = 525.69 + 2517.35 = 3043.04 \text{ credits.}$$
This successfully isolated 44,043 extreme transactions (3.37% of the database) for separate evaluation.
* **Behavioral and Segment Cohorts**: Players were grouped dynamically into analytical subsets based on character race (race_id) and total purchase value to distinctly evaluate purchasing frequency against average check sizes.  

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
