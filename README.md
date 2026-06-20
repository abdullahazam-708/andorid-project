# Flutter & Dart Mobile Applications Portfolio

Welcome to my portfolio repository containing a collection of cross-platform mobile applications built using the **Flutter SDK** and the **Dart Programming Language**. This repository serves as a showcase of my technical skills in mobile development, state management, database integration, API consumption, and asynchronous programming.

---

## 🛠️ Technical Skills Demonstrated
* **Mobile Development:** Flutter SDK, Dart, Cross-Platform App Architecture, Adaptive UI Layouts
* **State Management:** BLoC (Business Logic Component), Riverpod, Provider, setState
* **Databases & Local Storage:** SQLite (SQFlite package), Firebase Firestore (Real-time Cloud Database), In-Memory Collections
* **APIs & Networking:** REST APIs, JSON Serialization/Deserialization, HTTP Networking, Async/Await Futures
* **Key Core Practices:** CRUD Operations, Live User Input Form Validation, Async Timers, Navigator Routing

---

## 📂 Project Catalog

### 1. Cloud-Integrated Smartphone Inventory System (`firebaseIntigreation`)
* **Description:** A mobile inventory manager integrated with **Firebase Firestore** for real-time CRUD operations, automatic cloud synchronization, and responsive document streaming.
* **Skills & Tech:** Flutter, Dart, Firebase Firestore Integration, Real-Time Data Streaming (`StreamBuilder`), State binding (`StatefulWidget`), Cloud Database CRUD operations.

### 2. SQLite Bookstore Database Manager (`finallabexam`)
* **Description:** A local bookstore inventory application featuring local persistent storage using the **SQFlite** package. Implements a helper singleton to query, add, update, and delete records offline.
* **Skills & Tech:** SQLite (`sqflite` package), custom database helpers (Singleton pattern), Local Database CRUD operations, Asynchronous UI Rendering (`FutureBuilder`), Data Models (Map conversion).

### 3. Real-Time Weather Forecasting Application (`fluter_weather_app`)
* **Description:** A live weather tracking application querying current meteorological stats from the OpenWeatherMap API using the `http` package and parsing raw JSON responses dynamically.
* **Skills & Tech:** REST APIs, HTTP networking (`http` package), JSON decoding (`dart:convert`), client-side loading states, dynamic data rendering, HTTP error handling.

### 4. Live Exchange Rate Currency Converter (`flutter_curreny_app`)
* **Description:** A converter utility leveraging external currency rate REST APIs to fetch the latest rates and convert amounts dynamically with user dropdown menus.
* **Skills & Tech:** External REST API queries, math state calculations, third-party dropdown widgets (`dropdown_button2`).

### 5. BLoC State-Managed Calculator (`bloc_example`)
* **Description:** An interactive calculator project showcasing clean architectural separation of UI from logic using the BLoC pattern.
* **Skills & Tech:** BLoC (Business Logic Component) pattern, State-Event separation architecture, custom event classes, stateless UI components, `flutter_bloc` integration.

### 6. Riverpod State Calculator (`riverpodcalculatorapp`)
* **Description:** An interactive calculator project showcasing reactive UI building and global state providers.
* **Skills & Tech:** Riverpod state management, `StateNotifier` architectures, reactive UI building (`ConsumerWidget`), global state providers.

### 7. Provider-Based Student Directory System (`providerexamplle`)
* **Description:** A student listing and data management interface utilizing the **Provider** framework to publish and share app-level changes efficiently across nested widgets.
* **Skills & Tech:** Provider pattern, state notify-listeners mechanism (`ChangeNotifier`), state injection (`ChangeNotifierProvider`), dynamic UI updates.

### 8. SQLite User Authentication & CRUD Dashboard (`sqlliteproject`)
* **Description:** A user dashboard featuring local SQLite-backed registration, authentication flows, and a CRUD database profile screen.
* **Skills & Tech:** User signup/login validations, local session state control, SQLite database lookups.

### 9. Performance-Optimized Employee Directory (`listview_employee`)
* **Description:** A layout directory rendering data lists efficiently using Flutter's `ListView.builder` adapters to optimize memory footprint.
* **Skills & Tech:** Flutter list performance optimizations (`ListView.builder`), dynamic list mapping, custom UI list adapters.

### 10. Product Catalog & Data Validator (`openendedlab`)
* **Description:** An in-memory inventory listing app featuring live validation inputs, negative value prevention, and item entry checking.
* **Skills & Tech:** Client-side data integrity validation, in-memory collection updates, user error feedback (`SnackBar`).

### 11. Asynchronous Stopwatch & Timer Utility (`stopwatch_app`)
* **Description:** An elegant custom stopwatch utility displaying a clean interface while managing async periodic timers and state controls.
* **Skills & Tech:** Dart asynchronous library (`Timer.periodic`), custom time formatting algorithms, linear gradient background layouts.

### 12. Multi-Screen Navigator Showcase (`newapp`)
* **Description:** An application demonstrating multi-page routing, page-to-page state transfers, and Navigator controllers in Flutter.
* **Skills & Tech:** Flutter navigation routing (`Navigator.push`), context-based arguments passing, multi-screen state transfer.

### 13. Input Validator and Form Controller (`datavalidationflutterapp`)
* **Description:** A validation interface showcasing input validation patterns, email/password regex verification, and real-time form checks.
* **Skills & Tech:** Form state management, email/password regex validation patterns, form controller status checks.
