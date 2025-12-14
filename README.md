# 🐾 Dog Health Ecosystem

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![IoT](https://img.shields.io/badge/IoT-Sensors-orange.svg)
![WearOS](https://img.shields.io/badge/Platform-WearOS-teal.svg)
![Android TV](https://img.shields.io/badge/Platform-Android%20TV-green.svg)

**Dog Health** is a comprehensive multi-platform ecosystem designed for real-time monitoring of canine health. It integrates IoT sensors with a cross-platform Flutter application to provide vital signs tracking, emergency alerts, and historical health data analysis.

---

## 🌐 Ecosystem Architecture

The system is built on a unified Flutter codebase targeting multiple touchpoints:

### 📱 Mobile App (Guardian View)
*   **Real-time Dashboard**: Live feed of heart rate, temperature, and activity levels.
*   **Statistical Analysis**: `fl_chart` integration for visualizing health trends over time.
*   **Auth System**: Secure Google Sign-In integration.
*   **Profile Management**: Detailed medical history for multiple pets (`Canino.dart`).

### ⌚ Wear OS (Quick Alerts)
*   **wrist-based Notifications**: Instant vibration alerts for critical health anomalies.
*   **Glanceable Data**: Simplified UI for checking vital signs on the go.

### 📺 Android TV (Clinic Dashboard)
*   **Waiting Room Monitor**: Large-screen optimized view for veterinary clinics to monitor hospitalized pets.
*   **Multi-Dog Grid**: Simultaneous tracking of multiple patients.

### 📡 IoT Integration
*   **Smart Collar Sync**: Bluetooth LE / Wi-Fi connection to custom hardware sensors.
*   **Data Logging**: Automated background synchronization to the cloud.

---

> [!WARNING]
> **Web Demo Limitations**: 
> The web version of this application demonstrates the UI/UX and logic. Hardware-dependent features (Bluetooth sensors, Wear OS sync, and background services) are disabled in the browser environment.
> For the full experience, the application must be deployed on physical Android/iOS devices.

---

## 🛠️ Technology Stack

*   **Framework**: Flutter (Dart)
*   **Authentication**: Google Sign-In & Firebase Auth
*   **State Management**: Provider / Bloc (Architecture dependent)
*   **Data Visualization**: `fl_chart`, `chart_sparkline`
*   **Local Storage**: `shared_preferences` for settings caching
*   **Target Platforms**: iOS, Android, Web, WearOS, Android TV

---

## 🚀 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/SpideryBook7/dog-health.git
    cd dog-health
    ```

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run on Device**:
    *   *Mobile*: `flutter run -d <device_id>`
    *   *WearOS*: `flutter run -d <watch_id>`
    *   *TV*: `flutter run -d <tv_id>`

---
**Developed by Cristian Huerta - 2024**
