# SubTrain
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/OmarMonem02/SubTrain)

SubTrain is a comprehensive Flutter application designed to streamline the booking process for both subway and long-distance train travel. It provides a unified platform for users to search, book, and manage their tickets, integrating features like real-time scheduling, secure payments, and user support.

## Features

- **Dual-Mode Booking:** Seamlessly switch between booking tickets for subways and national trains.
- **User Authentication:** Secure sign-up and sign-in functionality, including Google Sign-In, managed with Firebase Authentication.
- **Train Booking System:**
    - Search for available train schedules based on departure/arrival stations, date, and class.
    - Interactive seat picker to select preferred seats.
    - View detailed trip information before booking.
- **Subway Booking System:**
    - Search for subway stations and view them on a map.
    - A smart pathfinder algorithm calculates the shortest route between two stations.
    - Dynamic fare calculation based on the travel distance (number of stations).
    - Locate the nearest subway station using your device's GPS.
- **Payment Integration:**
    - In-app wallet system for quick and easy payments.
    - Securely add money to your wallet using the Paymob payment gateway.
- **Ticket Management:**
    - View all active train and subway tickets in a dedicated section.
    - Generate QR codes for each ticket for validation purposes.
- **User Profile:**
    - Manage personal information.
    - View a history of previous trips.
    - Save favorite routes for quick booking.
    - Receive and view important announcements.
- **Admin & Support:**
    - **Admin Dashboard:** A special interface for administrators to add and manage train schedules.
    - **Ticket Validator:** Admins can validate tickets using a built-in QR code scanner.
    - **Live Customer Support:** A dedicated chat interface for users to communicate with the support team.
- **AI Chatbot:** An integrated chatbot powered by Google Gemini to answer user queries and provide assistance.

## Technology Stack

- **Framework:** Flutter
- **Backend & Database:** Firebase (Authentication, Cloud Firestore)
- **Payment Gateway:** Paymob
- **AI Chatbot:** Google Generative AI (Gemini)
- **Maps & Location:** Google Maps, Geolocator

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK installed on your machine.
- An editor like VS Code or Android Studio.
- A Firebase project set up.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/OmarMonem02/SubTrain.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd SubTrain
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Firebase Setup:**
    - Replace the placeholder `google-services.json` file in `android/app/` with your own Firebase configuration file for Android.
    - Replace the placeholder `GoogleService-Info.plist` file in `ios/Runner/` with your own Firebase configuration file for iOS.
5.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Structure

The project's main logic is located in the `lib` directory, organized as follows:

```
lib/
├── Admin_Pages/      # Admin-specific features like adding schedules and ticket validation.
├── Chat_Bot/         # AI-powered chatbot interface.
├── Payments/         # Logic for Paymob integration and wallet management.
├── Screens/          # Main UI screens for the application.
│   ├── BookingProcess/ # UI for booking trains and subways.
│   ├── Home/         # Home screen components.
│   ├── Profile/      # User profile, favorites, and history screens.
│   ├── Tickets/      # UI for displaying active tickets.
│   └── auth/         # Authentication screens (Welcome, Sign-In, Sign-Up).
├── Style/            # Centralized app styles, colors, and fonts.
├── Support_Pages/    # UI and services for live customer support chat.
├── widgets/          # Reusable custom widgets used throughout the app.
└── main.dart         # The main entry point of the application.
