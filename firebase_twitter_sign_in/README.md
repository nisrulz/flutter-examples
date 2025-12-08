# firebase_twitter_sign_in

A new Flutter project.

# Prerequisites

Make sure you have:

- A Twitter Developer account  
- FlutterFire CLI installed:
```bash
dart pub global activate flutterfire_cli
```

## Getting Started

## 1. Create Firebase Project
1. Go to https://console.firebase.google.com  
2. Create a new Firebase project  
3. Add an Android app to Firebase  
4. Use the package name:
'' github.nisrulz.firebase_google_authentication ''
5. Download the google-services.json file  
6. Place it inside:
android/app/google-services.json

## 2. Add SHA Keys
In Firebase Console → Project Settings → App → SHA Certificates

Add:
- SHA-1  
- SHA-256

## 3. Generate firebase_options.dart
Generate using:
flutterfire configure

This creates:
lib/firebase_options.dart

## 4. Enable Authentication in Firebase
1. Go to Firebase Console → Authentication  
2. Click Get Started  
3. Enable Twitter under Sign-in providers

# Twitter Developer Setup

## 1. Create a Twitter Developer App
1. Visit https://developer.twitter.com  
2. Open Developer Portal  
3. Create a new Project + App

## 2. Configure App Authentication
Inside your Twitter App → User Authentication Settings:

Enable:
- OAuth 1.0a  
- 3-legged OAuth  
- Request email

## 3. Callback URLs
Add the callback url given by firebase 

## 4. Get Twitter API Keys
Twitter Developer Portal → App → Keys and Tokens → Consumer Keys

Copy:
- API Key  
- API Key Secret

Paste these into Firebase:
Firebase Console → Authentication → Twitter

# Install Dependencies
``` 
flutter pub get
```

# Run the Project
```
flutter run
```