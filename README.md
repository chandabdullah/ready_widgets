# ready_widgets

[![Pub Version](https://img.shields.io/pub/v/ready_widgets)](https://pub.dev/packages/ready_widgets)
[![Pub Points](https://badges.bar/ready_widgets/pub%20points)](https://pub.dev/packages/ready_widgets/score)
![Platform](https://img.shields.io/badge/platform-flutter-blue)

A Flutter package with reusable custom widgets. Starting with `CustomInput`, this package helps you build cleaner UIs with minimal setup and no third-party dependencies.

---

## 🚀 Installation

Add `ready_widgets:` to your **pubspec.yaml** dependencies, then run:

```bash
dependencies:
  ready_widgets:
```
then
```bash
flutter pub get
```
---
## 📚 How to Use

Add this line to import the package:
```dart
import 'package:ready_widgets/ready_widgets.dart';
```

#### Basic Input
```dart
CustomInput(
  title: 'Name',
  hint: 'Enter your name',
  controller: controller,
),
```
#### Disabled Input
```dart
CustomInput(
  title: 'Disabled Input',
  hint: 'This input is disabled',
  enabled: false,
),
```
#### Read-Only Input
```dart
CustomInput(
  title: 'Read-Only Input',
  hint: 'This input is read-only',
  readOnly: true,
),
```
#### Suffix Icon Input
```dart
CustomInput(
  title: 'Suffix Icon Input',
  hint: 'This input has a suffix icon',
  suffixIcon: Icon(Icons.info_outline),
),
```
#### Prefix Icon Input
```dart
CustomInput(
  title: 'Prefix Icon Input',
  hint: 'This input has a prefix icon',
  prefixIcon: Icon(Icons.info_outline),
),
```
#### Obscure Text Input
```dart
CustomInput(
  title: 'Obscure Input',
  hint: 'Enter password',
  prefixIcon: Icon(Icons.lock),
  suffixIcon: Icon(Icons.visibility_off),
  isObscure: true,
),
```
---
## ☕ Support Me
<a href="https://www.buymeacoffee.com/chandabdullah21" target="_blank"> <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;"> </a> 

---
