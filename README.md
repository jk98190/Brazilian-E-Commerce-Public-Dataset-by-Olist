# Brazilian E-Commerce Public Dataset by Olist

Exploratory data analysis and modeling project built on the **Olist Brazilian E-Commerce Public Dataset**, sourced from Kaggle:
🔗 https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

## About the Dataset

This is a real, anonymized dataset of **100,000 orders** made between **2016 and 2018** across multiple online marketplaces in Brazil, generously provided by **Olist**, the largest department store in Brazilian marketplaces. Olist connects small businesses across Brazil to sales channels through a single contract, and those merchants ship products directly to customers via Olist's logistics partners.

The dataset lets you view a single order from multiple angles — order status, price, payment, and freight performance, through to customer location, product attributes, and the review left after delivery. After a customer receives their order (or the estimated delivery date passes), they receive a satisfaction survey where they can leave a score and written comments.

A companion **geolocation dataset** is also included, mapping Brazilian zip codes to latitude/longitude coordinates.

> **Note:** This is real commercial data that has been anonymized. References to companies and partners in review text have been replaced with the names of *Game of Thrones* great houses.

## Data Structure

The dataset is split across 9 relational CSV files, joined primarily on `order_id`, `customer_id`, `product_id`, and `seller_id`:

| File | Description |
|---|---|
| `olist_orders_dataset.csv` | Core order records — status, purchase timestamp, approval date, delivery dates, and estimated delivery date |
| `olist_order_items_dataset.csv` | One row per item within an order — product, seller, price, freight value, shipping limit date |
| `olist_customers_dataset.csv` | Customer ID, zip code, city, and state |
| `olist_sellers_dataset.csv` | Seller ID, zip code, city, and state |
| `olist_order_payments_dataset.csv` | Payment type, number of installments, and payment value per order |
| `olist_order_reviews_dataset.csv` | Review ID, order ID, review score, comment title/message, and review timestamps |
| `olist_products_dataset.csv` | Product ID, category, and physical dimensions/weight |
| `olist_geolocation_dataset.csv` | Zip code prefixes mapped to lat/lng, city, and state |
| `product_category_name_translation.csv` | Translates Portuguese product category names to English |

## Potential Use Cases

- **Delivery performance** — compare estimated vs. actual delivery dates, identify delay drivers
- **Customer satisfaction / review analysis** — text/NLP analysis of review comments, score prediction
- **Sales & demand forecasting** — time series analysis using purchase timestamps
- **Geospatial analysis** — customer/seller distribution using the geolocation dataset
- **Product category insights** — which categories drive revenue or dissatisfaction
- **Payment behavior** — installment patterns and payment method preferences
- **Customer segmentation / clustering** — RFM analysis, lifetime value estimation

## Getting Started

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (requires a free Kaggle account) or via the Kaggle API:
   ```bash
   kaggle datasets download -d olistbr/brazilian-ecommerce
   ```
2. Unzip into a local `data/` folder.
3. Load and join tables with `pandas` as needed for your analysis (see suggested join keys above).

## Attribution

Dataset created and released by **Olist** (www.olist.com) on Kaggle. Please refer to the original Kaggle page for the dataset's license terms before using it in derivative or commercial work.

## License

This repository's code is provided as-is. The underlying dataset's license and usage terms are governed by the terms set on the [Kaggle dataset page](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — check there for current licensing details.
