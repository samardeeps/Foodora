Foodora – Food Delivery App (Internship Task for Nestafar)

This project is developed as part of the Nestafar Internship Assignment.
The task was to implement a single workflow for ordering food from local restaurants, following clean architecture principles, realistic steps, and state management using BloC.

📸 Screenshots
 Attached Scren recording in the chat
 https://drive.google.com/drive/folders/1mrF1CrrRYKN2SHtachwly_sWO07j08ra?usp=sharing

🚀 Features

Browse local restaurants

Search for restaurants and cuisines

View restaurant details with menu items

Add items to cart and review before ordering

Place and view confirmed orders

Smooth animations and aesthetic UI

Error handling with proper fallback states

Auto-scrolling promotional banners on Home Screen

Add to cart with correct handling 

Order managment 

Empty cart for new order

🛠️ Tech Stack

Framework: Flutter

State Management: BloC

Architecture: SOLID principles applied

Animations: Lottie + Flutter animation controller

Testing: Unit tests for core workflow

📂 Project Structure
lib/
 ├── blocs/           # BloC state management (Restaurant, Cart, Orders)
 ├── models/          # Data models (Restaurant, MenuItem, Order)
 ├── repositories/    # Repository layer for fetching mock data
 ├── screens/         # UI Screens (Home, Details, Cart, Orders, Profile)
 ├── widgets/         # Reusable UI components (Cards, NavBar, etc.)
 └── utils/           # Theme, constants, helpers

🧪 Unit Tests

Unit tests are included for the workflow:

Restaurant search logic

Cart item add/remove

Order confirmation

Run tests with:

flutter test

▶️ Getting Started
Prerequisites

Flutter SDK
 (latest stable)

Android Studio / VS Code with Flutter plugin

Installation
# Clone the repository
git clone https://github.com/samardeeps/Foodora.git

# Navigate into project folder
cd foodora_nestafar

# Get dependencies
flutter pub get

# Run the app
flutter run

⚠️ Notes

No authentication (login/signup) is implemented, as per task requirements.

Data is mock/local for demo purposes.

Designed to be easily extended with APIs later.

🙌 Acknowledgement

This project was built as part of the Nestafar Internship Assignment given by Shubhojyoti.
Deadline: 30 September, 2025.