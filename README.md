# 👗 Shahanaz Tailors & Fabrics

### Fashion Shopping & Custom Dress App

**A Flutter-Based Fashion E-Commerce and Customization Platform**

---

## 📌 Project Overview

**Shahanaz Tailors & Fabrics** is a modern Flutter-based fashion e-commerce and custom tailoring application.

The application combines **fashion shopping, fabric selection, dress customization, tailoring, order management, and customer support** into one platform.

Customers can browse ready-made dresses, select fabrics, customize their own dresses, provide measurements, place orders, and track their orders from their mobile devices.

### 🎯 Main Concept

> **Discover → Customize → Order → Track → Review**

---

## ✨ Features

### 🛍️ Fashion Shopping

Users can:

* Browse ready-made dresses
* View product details
* Search products
* Browse categories
* Check prices
* View available sizes
* View colors and fabric information
* Add products to Cart
* Add products to Favorites
* View ratings and reviews

---

### 🎨 Custom Dress Designer

The Custom Dress Designer is one of the main features of the application.

Users can create their own dress by selecting:

* 👗 Dress Type
* 🧵 Fabric
* 🎨 Color
* 👚 Neck Design
* 🧥 Sleeve Design
* 📏 Dress Length
* 📐 Size
* 📋 Custom Measurements
* 🖼️ Reference Design Image

After completing the customization, users can review their design and place an order.

---

### 🧵 Fabric Information

The application provides information about different fabrics.

Available fabric examples include:

* Cotton
* Silk
* Linen
* Chiffon
* Georgette
* Velvet
* Organza

Users can view:

* Fabric name
* Description
* Appearance
* Suitable seasons
* Care instructions
* Approximate price

---

### ❤️ Favorites

Users can save their favorite:

* Ready-made dresses
* Products
* Custom designs

This allows users to easily find products later.

---

### 🛒 Shopping Cart

The Cart allows users to:

* Add products
* Remove products
* Increase quantity
* Decrease quantity
* Select size
* Select color
* View customization details

The cart also displays:

* Subtotal
* Customization cost
* Delivery charge
* Total amount

---

### 💳 Checkout

The checkout system includes:

* Delivery address
* Payment method
* Order summary
* Price breakdown
* Total amount

Payment options can include:

* Cash on Delivery
* Demo Card Payment
* Mobile Payment UI

---

### 📏 Measurement Management

Customers can save their body measurements for customized dresses.

Example measurements:

* Shoulder
* Chest
* Waist
* Hip
* Sleeve Length
* Dress Length

Users can:

* Add measurements
* Edit measurements
* Delete measurements
* Reuse saved measurements for future orders

---

### 📦 Order Tracking

Customers can track their order progress.

### Order Status

```text
Order Placed
      ↓
Order Confirmed
      ↓
Processing
      ↓
Making
      ↓
Ready
      ↓
Out for Delivery
      ↓
Delivered
```

This provides customers with clear information about the current status of their orders.

---

### ⭐ Reviews & Ratings

Customers can:

* Give ratings
* Write reviews
* Upload product photos
* View other customers' reviews

---

### 🔔 Notifications

The application can notify users about:

* Order confirmation
* Custom dress progress
* Delivery updates
* New collections
* Discounts
* Special offers

---

### 👤 User Profile

The Profile section includes:

* Personal Information
* My Orders
* Favorites
* Saved Measurements
* Saved Addresses
* Payment Methods
* Notifications
* Settings
* Help & Support
* About Us
* Logout

---

### 🛠️ Admin Panel

The application also includes an Admin Panel concept.

Administrators can manage:

* Products
* Categories
* Fabrics
* Orders
* Customers
* Reviews
* Discounts
* Stock

The Admin Dashboard can display:

* Total Products
* Total Orders
* Pending Orders
* Completed Orders
* Total Customers

---

# 📱 Application Screens

The application includes the following major screens:

* Splash Screen
* Onboarding
* Login
* Registration
* Home
* Shop
* Product Details
* Custom Dress Designer
* Fabrics
* Fabric Details
* Favorites
* Cart
* Checkout
* Order Success
* Orders
* Order Details
* Order Tracking
* Measurements
* Notifications
* Profile
* Settings
* Help & Support
* About Us
* Admin Dashboard

---

# 🎨 UI & Design

The application uses a modern and elegant fashion-oriented design.

### Design Theme

* 🌸 Soft Pink
* 🎀 Baby Pink
* 🤍 White
* 🌹 Light Rose
* ✨ Rose Gold / Gold accents
* 🖤 Dark text

The UI focuses on:

* Clean layouts
* Rounded cards
* Modern icons
* Product images
* Smooth navigation
* Attractive buttons
* Responsive layouts
* Elegant typography
* User-friendly interactions

---

# 🧰 Technology Stack

## Frontend

**Flutter**

**Dart**

---

## State Management

**Riverpod**

Riverpod is used for managing application states such as:

* Cart
* Favorites
* Products
* Orders
* User Profile
* Measurements
* Customization

---

## Navigation

**GoRouter**

Used for application navigation and route management.

---

## Backend

The project is prepared for:

**Firebase**

---

## Database

**Cloud Firestore**

Potential collections include:

```text
users
products
categories
fabrics
orders
custom_orders
measurements
favorites
reviews
notifications
```

---

## Authentication

**Firebase Authentication**

Used for:

* Login
* Registration
* User authentication
* Password management

---

## Storage

**Firebase Storage**

Can be used for:

* Product images
* Profile images
* Reference dress images
* Review images

---

## Notifications

**Firebase Cloud Messaging**

Can be used for:

* Order updates
* Delivery notifications
* Promotions
* Custom order progress

---

# 📂 Project Structure

```text
lib/
│
├── main.dart
├── app.dart
│
├── core/
│   ├── theme/
│   ├── constants/
│   ├── routes/
│   └── utils/
│
├── models/
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── fabric_model.dart
│   ├── order_model.dart
│   ├── measurement_model.dart
│   └── review_model.dart
│
├── providers/
│   ├── product_provider.dart
│   ├── cart_provider.dart
│   ├── favorite_provider.dart
│   ├── order_provider.dart
│   └── user_provider.dart
│
├── services/
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── storage_service.dart
│
├── data/
│   └── demo_data.dart
│
├── screens/
│   ├── splash/
│   ├── onboarding/
│   ├── auth/
│   ├── home/
│   ├── products/
│   ├── product_details/
│   ├── customization/
│   ├── fabrics/
│   ├── cart/
│   ├── checkout/
│   ├── orders/
│   ├── favorites/
│   ├── measurements/
│   ├── notifications/
│   ├── profile/
│   ├── settings/
│   ├── help/
│   ├── about/
│   └── admin/
│
└── widgets/
    ├── product_card.dart
    ├── category_card.dart
    ├── custom_button.dart
    ├── app_text_field.dart
    ├── price_widget.dart
    └── order_status_timeline.dart
```

---

# 🚀 Getting Started

## 1. Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

Then enter the project folder:

```bash
cd shahanaz-tailors-and-fabrics
```

---

## 2. Install Dependencies

Run:

```bash
flutter pub get
```

---

## 3. Check Flutter Environment

Run:

```bash
flutter doctor
```

Make sure your Flutter environment is properly configured.

---

## 4. Run the Application

For Chrome:

```bash
flutter run -d chrome
```

For Android:

```bash
flutter run
```

---

# 📦 Build APK

To create an Android release APK:

```bash
flutter build apk --release
```

The generated APK can normally be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

You can transfer this APK to an Android phone and install it.

---

# 🔥 Firebase Configuration

The application architecture is prepared for Firebase integration.

To use the complete Firebase functionality, configure:

* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Firebase Cloud Messaging

For Android, add the Firebase configuration file:

```text
android/app/google-services.json
```

Then configure the Firebase project according to the Flutter Firebase setup requirements.

---

# 🧪 Testing & Code Quality

The project can be checked using:

```bash
flutter analyze
```

Get dependencies using:

```bash
flutter pub get
```

Run the application using:

```bash
flutter run
```

---

# 📸 Screenshots

Add your application screenshots here.

Example:

```markdown
## 📸 Screenshots

### Home Screen

![Home Screen](screenshots/home.png)

### Shop Screen

![Shop Screen](screenshots/shop.png)

### Custom Dress Designer

![Custom Dress](screenshots/customize.png)

### Product Details

![Product Details](screenshots/product-details.png)

### Cart

![Cart](screenshots/cart.png)

### Order Tracking

![Order Tracking](screenshots/orders.png)

### Profile

![Profile](screenshots/profile.png)
```

Create a folder in your repository:

```text
screenshots/
```

Then put your screenshots inside it.

For example:

```text
screenshots/
├── home.png
├── shop.png
├── customize.png
├── product-details.png
├── cart.png
├── orders.png
└── profile.png
```

---

# 🌟 Future Scope

Future versions of the application can include:

* 🤖 AI-based dress recommendations
* 👗 Virtual dress try-on
* 🎨 AI design generation
* 🧍 3D dress preview
* 💳 Real online payment gateway
* 💬 Live chat with tailor
* 🚚 Delivery partner integration
* ✨ Personalized fashion recommendations
* 🏪 Multiple seller support
* 📊 Advanced seller analytics
* 📱 Push notification system
* ☁️ Full cloud synchronization

---

# 🎯 Project Goals

The main goals of Shahanaz Tailors & Fabrics are:

1. Make fashion shopping easier.
2. Provide online custom dress design.
3. Allow customers to choose fabrics and designs.
4. Make measurement management easier.
5. Provide convenient online ordering.
6. Allow customers to track custom orders.
7. Combine shopping and tailoring in one platform.
8. Provide a modern and user-friendly fashion experience.

---

# 👩‍💻 Developer

**Presented / Developed By:**

### Jyoti

**Department of Computer Science & Engineering**

**Shanto Mariam University of Creative Technology**

---

# 🏷️ Project Information

| Information      | Details                               |
| ---------------- | ------------------------------------- |
| Project Name     | Shahanaz Tailors & Fabrics            |
| Platform         | Flutter                               |
| Language         | Dart                                  |
| Application Type | Fashion E-Commerce & Custom Tailoring |
| State Management | Riverpod                              |
| Navigation       | GoRouter                              |
| Backend          | Firebase                              |
| Database         | Cloud Firestore                       |
| Authentication   | Firebase Authentication               |
| Storage          | Firebase Storage                      |
| Notifications    | Firebase Cloud Messaging              |

---

# 💡 Project Vision

> **"Your Style. Your Fabric. Your Dress."**

Shahanaz Tailors & Fabrics aims to provide a complete digital fashion experience where customers can discover fashion, choose fabrics, customize their own designs, place orders, and track their dresses from one convenient application.

---

# ❤️ Conclusion

**Shahanaz Tailors & Fabrics** brings fashion shopping and custom tailoring together in one modern mobile application.

Instead of visiting multiple places for:

**Shopping + Fabric Selection + Customization + Measurements + Tailoring + Order Tracking**

customers can manage the complete process from a single platform.

### Discover → Customize → Order → Track → Review

---

# 🙏 Thank You

**Shahanaz Tailors & Fabrics**

### *Your Style. Your Fabric. Your Dress.*
