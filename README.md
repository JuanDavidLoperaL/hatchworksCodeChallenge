# HatchworksCodeChallenge

HatchworksCodeChallenge is a technical challenge project for an iOS interview. The app simulates a small store that consumes the free [DummyJSON API](https://dummyjson.com/products) to display products and manage purchases, with local persistence using Core Data.

⚠️ **Important:** This project is **not compatible with Xcode 26** because the **Kingfisher** library, used for image handling and caching, is not yet ready for that version. Please use **Xcode 16**.

---
## Project Achitecture
For this project, I selected the MVVM-C architecture, as I’m familiar with it and it provides a clean and scalable structure for small applications.

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

## Unit test
I added unit tests for each ViewModel, since that’s where the business logic is located. The unit tests follow the same folder structure as the main project. I tried to cover all the possible cases I could think of.
I used mock data for the tests, including mock data for the Core Data layer.
I used native XCTest instead of any third-party frameworks for testing purposes.

---

## Technologies
- **Swift / SwiftUI**  
- **Core Data** for local persistence  
- **Kingfisher** for image loading and caching  
- **Unit Tests** for validating screen functionality
- **Swift Concurrency** for threads handling 

---
