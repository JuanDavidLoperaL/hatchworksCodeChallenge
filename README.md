# hatchworksCodeChallenge

# HatchworksCodeChallenge

HatchworksCodeChallenge is a technical challenge project for an iOS interview. The app simulates a small store that consumes the free [DummyJSON API](https://dummyjson.com/products) to display products and manage purchases, with local persistence using Core Data.

⚠️ **Important:** This project is **not compatible with Xcode 26** because the **Kingfisher** library, used for image handling and caching, is not yet ready for that version. Please use **Xcode 16**.

---

## Features

### 1. Home (Product List)
- Displays a list of products fetched from the API `https://dummyjson.com/products`.  
- Each product includes:  
  - Title  
  - Price  
  - Discount  
  - Availability  
- All information is in English.  

### 2. Product Detail
- When selecting a product, detailed information is displayed from `https://dummyjson.com/products/{id}`:  
  - Product image  
  - Title  
  - Description  
  - Price  
  - Discount  
  - Shipping information  
  - Warranty information  
  - Inventory status  
  - "Buy" button  
- When a product is purchased, it is saved locally using Core Data for persistence.  

### 3. History (Purchase History)
- Shows a list of previously purchased products.  
- Each item displays:  
  - Product image  
  - Title  
  - Price  
  - Purchase date  
  - Shipping information  
- Data is loaded from Core Data.  

---

## Technologies
- **Swift / SwiftUI**  
- **Core Data** for local persistence  
- **Kingfisher** for image loading and caching  
- **Unit Tests** for validating screen functionality
- **Swift Concurrency** for threads handling 

---
