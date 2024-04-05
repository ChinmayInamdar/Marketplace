# Marketplace - Your Ultimate Flutter E-commerce Solution

Marketplace is a feature-rich Flutter-based e-commerce mobile application that empowers users to browse, purchase, and manage products seamlessly. Whether you're a buyer looking for the latest trends or a seller eager to showcase your products, Marketplace has got you covered.

## Features

### Authentication
- **Sign Up/Login**: Users can easily create an account or log in securely using their email and password.
- **Firebase Authentication**: Built-in Firebase authentication ensures robust security and hassle-free login.

### Shop Page
- **Product Showcase**: Browse through an extensive collection of products across various categories.
- **Intuitive UI**: Clean and user-friendly interface for effortless navigation and product discovery.

### Cart Management
- **Add to Cart**: Users can add products to their cart with just a tap.
- **Cart Preview**: Quickly review the items added to the cart before proceeding to checkout.
- **Local Storage**: Cart items are stored locally for seamless user experience.

### List Product Page (Admin Functionality)
- **Product Listing**: Admin users can list new products by providing details such as name, description, price, and uploading an image.
- **Image Upload**: Easily upload product images directly from the device gallery.
- **Firebase Integration**: Product information is stored in Firestore, while images are hosted on Firebase Storage.

## Technologies Used

- **Flutter**: Our app's frontend is built using the Flutter framework, enabling us to create a cross-platform mobile application with a native-like experience.
- **Firebase**: We've utilized various Firebase services such as Authentication, Firestore, and Storage for user authentication, data storage, and image hosting.
- **Provider Package**: Provider is used for state management, allowing us to efficiently manage and update application state throughout the app.

## Installation

To run the Marketplace app locally, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Set up Firebase for authentication, Firestore, and Storage.
5. Run the app using `flutter run`.

## Usage

1. Launch the Marketplace app on your device.
2. Sign up or log in to your account.
3. Explore various product categories on the Shop page.
4. Add products to your cart and proceed to checkout.
5. Admin users can list new products and upload images on the List Product page.

## Future Improvements

Marketplace is continuously evolving, and here are some future enhancements we're considering:

- **User Reviews**: Allow users to leave reviews and ratings for products.
- **Order Tracking**: Implement order tracking functionality for users to monitor their purchases.
- **Payment Integration**: Integrate payment gateways for seamless and secure transactions.

