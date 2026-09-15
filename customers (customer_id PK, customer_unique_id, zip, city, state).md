  
customers (customer\_id PK, customer\_unique\_id, zip, city, state)  
        │ customer\_id  
        ▼  
orders (order\_id PK, customer\_id FK, order\_status, purchase/approved/delivered/estimated dates)  
        │ order\_id                                  │ order\_id  
        ▼                                            ▼  
order\_items (order\_id FK, order\_item\_id, product\_id, seller\_id FK, price, freight\_value)   payments (order\_id FK, payment\_type, installments, payment\_value)  
        │ seller\_id  
        ▼  
sellers (seller\_id PK, zip, city, state)  
