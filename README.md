#  Yum Slice – E-Commerce Flutter App

**Yum Slice** is a cross-platform e-commerce mobile application built with **Flutter**, offering a smooth and interactive online shopping experience. Users can browse products, add items to their cart, place orders, submit reviews, apply promo codes, and complete payments via Visa using Paymob integration.

---

##  Features Overview

The app is structured into modular feature folders for scalability and clarity:

###  Authentication
- Firebase-based login and registration.
- Cubit used for managing authentication state.

###  Home
- Displays banners and access to main product categories (desserts, drinks, meals, snacks).

###  Shop
- Browse all products with support for:
  - **Category Filtering** (chips and bottom sheet)
  - **Sorting** (e.g., price, popularity)
  - **Pagination**
  - Real-time product count
- State managed using Cubit.

###  Product Details
- Detailed product information.
- Add to cart functionality.

###  Reviews
- Add and view product reviews.

###  Cart
- Add, update, and remove items.
- Apply promo codes.
- View total price.

###  Checkout
- Confirm address and payment method.

###  Payment
- Integrated with **Paymob** for Visa payments.
- Orders can be canceled if not yet prepared.

###  Orders
- Track current and past orders.
- Status updates: pending, preparing, delivered, canceled.

###  Favorites
- Save and manage favorite products.

###  Profile
- Update user data (name, phone, etc.).
- Change app theme (light/dark).
- Upload/change profile picture via `image_picker`.

---

##  Architecture

The app follows **Clean Architecture**:

- **State Management:** Cubit (`flutter_bloc`)
- **Layer Separation:**  
  - `data/`: data sources, models, repositories  
  - `domain/`: base repositories, use cases  
  - `presentation/`: cubits, components, screens

- **Dependency Injection:** Managed with `get_it` for service locator pattern.
- **Network Requests:** Handled using `dio` for efficient API calls and also `http` for simpler requests.
- **Local Storage:** Utilizes `shared_preferences` for theme and bool for onboarding state.

