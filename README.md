# ready_widgets

[![Pub Version](https://img.shields.io/pub/v/ready_widgets)](https://pub.dev/packages/ready_widgets)
[![Pub Points](https://badges.bar/ready_widgets/pub%20points)](https://pub.dev/packages/ready_widgets/score)
![Platform](https://img.shields.io/badge/platform-flutter-blue)

A Flutter package offering a collection of reusable, customizable widgets to streamline UI development with minimal setup and no third-party dependencies. This package includes buttons, inputs, avatars, network images, shimmer effects, and more.

---

## 🚀 Installation

Add `ready_widgets` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  ready_widgets: ^latest_version
```

Then run:

```bash
flutter pub get
```

Import the package in your Dart file:

```dart
import 'package:ready_widgets/ready_widgets.dart';
```

---

## 📚 Widgets and Usage

### 1. ReadyTextButton
A flexible text button with solid, outlined, or transparent styles, supporting icons and customizable sizes.

#### Example: Basic Transparent Button
```dart
ReadyTextButton(
  text: 'Click Me',
  onPress: () => print('Pressed!'),
),
```

#### Example: Solid Button with Icon
```dart
ReadyTextButton.solid(
  text: 'Submit',
  icon: Icons.check,
  iconPosition: IconPosition.leading,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  size: ReadyButtonSize.large,
),
```

#### Example: Outlined Button
```dart
ReadyTextButton.outlined(
  text: 'Cancel',
  borderColor: Colors.red,
  onPress: () => print('Cancelled!'),
),
```

### 2. ReadyLikeButton
A toggleable like button with animation, supporting solid, outlined, or transparent styles.

#### Example: Default Like Button
```dart
ReadyLikeButton(
  onPress: (isLiked) async {
    await Future.delayed(Duration(milliseconds: 500));
    return !isLiked;
  },
),
```

#### Example: Solid Like Button
```dart
ReadyLikeButton.solid(
  color: Colors.red,
  iconColor: Colors.white,
  size: ReadyButtonSize.large,
  isLiked: true,
),
```
### 3. ReadyIconButton
An icon-only button with support for badges, tooltips, and rounded or rectangular shapes.

#### Example: Basic Icon Button
```dart
ReadyIconButton(
  iconData: Icons.favorite_border,
  onPress: () => print('Icon pressed!'),
  tooltip: 'Favorite',
),
```

#### Example: Solid Icon Button with Badge
```dart
ReadyIconButton.solid(
  iconData: Icons.notifications,
  backgroundColor: Colors.blue,
  badge: 5,
  size: ReadyButtonSize.large,
),
```

### 4. ReadyElevatedButton
A customizable elevated button with optional icons and predefined size variants.

#### Example: Default Elevated Button
```dart
ReadyElevatedButton(
  text: 'Submit',
  onPress: () => print('Submitted!'),
),
```

#### Example: Small Button with Icon
```dart
ReadyElevatedButton.small(
  text: 'Save',
  icon: Icons.save,
  backgroundColor: Colors.green,
  textColor: Colors.white,
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_buttons.png" alt="Ready Buttons" height="500"/>

### 5. ReadyEmptyWidget
A widget for empty states with an animated icon, title, subtitle, and optional additional widget.

#### Example: Basic Empty State
```dart
ReadyEmptyWidget(
  title: 'No Data Found',
  subtitle: 'Try adding some items.',
  icon: Icons.info_outline,
),
```

#### Example: Custom Empty State with Button
```dart
ReadyEmptyWidget(
  title: 'Empty List',
  subtitle: 'Start by adding a new item.',
  customIcon: Icon(Icons.error, size: 40, color: Colors.red),
  additionalWidget: ReadyElevatedButton(
    text: 'Add Item',
    onPress: () => print('Add item pressed!'),
  ),
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_empty_widget.png" alt="Ready Empty Widget" height="500"/>

### 6. ReadyAvatar
An avatar widget displaying a network image or initials, with an optional online status indicator.

#### Example: Basic Avatar
```dart
ReadyAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  size: 60,
),
```

#### Example: Initials Avatar with Online Indicator
```dart
ReadyAvatar(
  name: 'John Doe',
  isOnline: true,
  size: 80,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
),
```
### 7. ReadyNetworkImage
A network image widget with shimmer loading and error handling.

#### Example: Basic Network Image
```dart
ReadyNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  width: 100,
  height: 100,
),
```

#### Example: Rounded Image with Custom Error
```dart
ReadyNetworkImage(
  imageUrl: 'https://example.com/invalid.jpg',
  width: 120,
  height: 120,
  isRounded: true,
  borderColor: Colors.blue,
  borderWidth: 2,
  errorWidget: Icon(Icons.error, size: 40),
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_images.png" alt="Ready Images" height="500"/>

### 8. ReadyInput
A customizable text input field with support for prefix/suffix icons, validation, and decoration styles.

#### Example: Basic Input
```dart
ReadyInput(
  label: 'Name',
  hint: 'Enter your name',
  controller: TextEditingController(),
),
```

#### Example: Password Input
```dart
ReadyInput(
  label: 'Password',
  hint: 'Enter your password',
  isObscure: true,
  prefixIcon: Icon(Icons.lock),
),
```
### 9. ReadyPhoneInput
A phone number input with a country code picker and localized country names.

#### Example: Basic Phone Input
```dart
ReadyPhoneInput(
  controller: TextEditingController(),
  onCountryChange: (country) => print('Selected: ${country.name}'),
  initialDialCode: '+1',
),
```

#### Example: Phone Input with Validation
```dart
ReadyPhoneInput(
  controller: TextEditingController(),
  onCountryChange: (country) => print('Country: ${country.dialCode}'),
  validator: (value) =>
      value!.length < 10 ? 'Phone number too short' : null,
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_inputs.png" alt="Ready Inputs" height="500"/>
<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_inputs_1.png" alt="Ready Inputs 1" height="500"/>

### 10. ReadyShimmer
A dependency-free shimmer effect for loading placeholders.

#### Example: Basic Shimmer
```dart
ReadyShimmer(
  width: 200,
  height: 100,
),
```

#### Example: Custom Shimmer Colors
```dart
ReadyShimmer(
  width: 150,
  height: 150,
  borderRadius: BorderRadius.circular(16),
  shimmerColors: [Colors.blue.shade200, Colors.blue.shade50, Colors.blue.shade200],
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_shimmers.png" alt="Ready Shimmer" height="500"/>

### 11. ReadyReadMoreText
A widget for trimming long text with "Read more" and "Read less" toggle links.

#### Example: Basic Read More
```dart
ReadyReadMoreText(
  text: 'This is a very long text that needs to be truncated because it exceeds the maximum number of lines allowed.',
  maxLines: 2,
),
```

#### Example: Length-Based Trimming
```dart
ReadyReadMoreText(
  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  trimMode: TrimMode.length,
  trimLength: 50,
  moreLessStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
),
```

<img src="https://raw.githubusercontent.com/chandabdullah/ready_widgets/main/assets/ready_text.png" alt="Ready Text" height="500"/>

---

## 🛠️ Features
- **No Third-Party Dependencies**: Lightweight and built with Flutter's core libraries.
- **Customizable**: Extensive styling options for colors, sizes, icons, and more.
- **Responsive**: Adapts to different screen sizes and orientations.
- **Platform Support**: Works on all Flutter-supported platforms (iOS, Android, web, etc.).
- **Interactive**: Includes animations (e.g., shimmer, like button scale) and interactive elements (e.g., country picker, read more links).

---

## ☕ Support the Developer
If you find `ready_widgets` helpful, consider supporting the developer:

<a href="https://www.buymeacoffee.com/chandabdullah21" target="_blank"> <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;"> </a>

---

## 📝 Notes
- **Documentation**: Check the [ready_widgets page on pub.dev](https://pub.dev/packages/ready_widgets) for the latest version and additional details.
- **Versioning**: Always use the latest version in `pubspec.yaml` to access new features and fixes.
- **Contributions**: Contributions, issues, and feature requests are welcome on the [package's GitHub repository](https://github.com/chandabdullah/ready_widgets).

If you have specific use cases or need further assistance, refer to the individual widget documentation or reach out to the developer community.