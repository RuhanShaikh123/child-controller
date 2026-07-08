# 📱 Child Controller

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Backend-orange?logo=firebase)
![Riverpod](https://img.shields.io/badge/Riverpod-State%20Management-green)
![Android](https://img.shields.io/badge/Platform-Android-success)
![Status](https://img.shields.io/badge/Status-Active%20Development-yellow)

A Flutter-based Child Controller application that securely connects a child's device with the Parent Controller. It manages permissions, synchronizes with Firebase, listens for remote commands, and provides real-time services such as location updates and live microphone streaming.

> ⚠️ This application is intended for authorized parental monitoring only. Device owners must explicitly grant the required permissions before any monitoring features become available.

---

# ✨ Features

## 🔐 Authentication

- Email & Password Login
- User Registration
- Firebase Authentication
- Persistent Login Session

---

## 🔗 Device Pairing

- Pair Code Connection
- QR Code Pairing
- Firebase Synchronization
- Secure Parent Linking

---

## 📍 Live Location

- Real-Time Location Updates
- Background Location Support
- Firestore Synchronization
- Address Resolution

---

## 🎤 Live Microphone

- Real-Time Audio Streaming
- WebSocket Communication
- Low Latency Streaming
- Background Microphone Service
- Render Hosted WebSocket Server

---

## 📷 Live Camera

- Camera Command Listener
- Camera Initialization
- Remote Camera Support
- Live Camera Module

---

## 🔒 Permission Management

Manage and monitor all required permissions.

- Camera Permission
- Microphone Permission
- Location Permission
- Accessibility Service
- Usage Access
- Overlay Permission
- Notification Access
- Battery Optimization

---

## ⚙️ Background Services

- Foreground Service
- WebSocket Manager
- Remote Command Listener
- Firebase Real-Time Updates
- Device Synchronization

---

# 🏗️ Project Architecture

The project follows a scalable **Feature-First Architecture**.

```
lib
│
├── apk
│
├── auth
│
├── features
│   ├── dashboard
│   ├── devices
│   ├── pairing
│   ├── permission
│   ├── location
│   ├── microphone
│   ├── live_camera
│   └── splash
│
├── router
│
└── main.dart
```

---

# 📂 Feature Structure

Each feature follows the same modular structure.

```
feature
│
├── data
│     └── datasource
│
├── repository
│     ├── repository.dart
│     └── repository_provider.dart
│
├── presentation
│     ├── screens
│     ├── widgets
│     └── providers
│
└── service
```

Example

```
microphone
│
├── service
│     ├── microphone_service.dart
│     ├── microphone_command_service.dart
│     └── websocket_service.dart
```

---

# 🧠 State Management

Riverpod

- Provider
- StateNotifierProvider
- Repository Pattern
- Dependency Injection
- Reactive State Management

---

# 🔥 Tech Stack

## Framework

- Flutter
- Dart

## Backend

- Firebase Authentication
- Cloud Firestore
- Firebase Storage

## State Management

- Riverpod

## Navigation

- GoRouter

## Real-Time Communication

- WebSocket

## Android Native

- Accessibility Service
- Foreground Service
- Java Integration
- Platform Channels

## Location

- Geolocator
- Geocoding

## Development

- Android Studio
- Git
- GitHub

---

# 📸 Screenshots

Coming Soon

- Login
- Register
- Pair Device
- Permission Screen
- Dashboard
- Live Location
- Live Microphone

---

# 🚀 Roadmap

## Completed

- ✅ Authentication
- ✅ Device Pairing
- ✅ Permission Management
- ✅ Live Location
- ✅ Live Microphone
- ✅ Foreground Service
- ✅ Accessibility Integration
- ✅ Firebase Synchronization

## In Progress

- 🚧 Live Camera Streaming
- 🚧 Remote Camera Commands

## Planned

- ⬜ Live Screen Sharing
- ⬜ Notification Monitoring
- ⬜ App Blocking
- ⬜ Website Blocking
- ⬜ Device Information
- ⬜ Battery Monitoring
- ⬜ Usage Statistics
- ⬜ WebRTC Integration

---

# 🔄 Companion Project

This repository works together with the **Parent Controller** application.

Parent Controller Repository:

https://github.com/RuhanShaikh123/parent-controller

---

# ⚙️ Installation

```bash
git clone https://github.com/RuhanShaikh123/child-controller.git

cd child-controller

flutter pub get

flutter run
```

---

# 📋 Requirements

- Flutter 3.x
- Dart 3.x
- Firebase Project
- Android Studio
- Android Device

---

# ⚠️ Disclaimer

This project is intended for educational purposes and authorized parental monitoring.

The application requires explicit permission from the device owner before enabling location, microphone, camera, accessibility, or other monitoring features.

---

# 👨‍💻 Author

**Ruhan Shaikh**

Flutter Developer

GitHub

https://github.com/RuhanShaikh123

Email

shaikhruhan555@gmail.com
