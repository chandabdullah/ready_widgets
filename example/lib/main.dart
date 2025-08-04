import 'package:example/appbar/custom_appbar.dart';
import 'package:example/bottombar/ready_bottombar.dart';
import 'package:example/buttons/ready_buttons.dart';
import 'package:example/empty/ready_empty_widget.dart';
import 'package:example/image/ready_avatar.dart';
import 'package:example/image/ready_network_image.dart';
import 'package:example/inputs/coutries.dart';
import 'package:example/inputs/ready_inputs.dart';
import 'package:example/shimmer/ready_shimmer.dart';
import 'package:example/text/ready_read_more_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(titleMedium: TextStyle(fontSize: 20)),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.purple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: ReadyInputs(controller: controller),
      // home: Scaffold(
      //   body: ReadyEmptyWidget(
      //     customIcon: Icon(
      //       Icons.wifi_off,
      //       size: 48,
      //       color: Colors.black54,
      //     ),
      //     backgroundColor: Colors.white12,
      //     additionalWidget: ReadyTextButton.solid(
      //       text: "Try Again",
      //       onPress: () {},
      //       size: ReadyButtonSize.small,
      //     ),
      //     icon: Icons.wifi_off,
      //     title: "Connection lost",
      //     subtitle: "Please try again later for better usage",
      //   ),
      // ),

      // home: Scaffold(
      //   body: SafeArea(
      //     child: SingleChildScrollView(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         children: [
      //           ReadyAvatar(
      //             name: "John Doe",
      //             isOnline: true,
      //             imageUrl:
      //                 "https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg",
      //           ),
      //           // ReadyShimmer(width: 200, height: 200),
      //           // SizedBox(height: 12),
      //           ReadyNetworkImage(
      //             imageUrl:
      //                 "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      //             width: 200,
      //             height: 200,
      //           ),
      //           ReadyReadMoreText(
      //             text:
      //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      //             trimMode: TrimMode.line,
      //             trimLines: 3,
      //             trimLength: 300,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class ReadyInputs extends StatelessWidget {
  const ReadyInputs({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReadyAppBar(titleText: "Ready Inputs"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadyInput(
              hint: 'Enter your name',
              controller: controller,
              label: "Name",
              decorationType: InputDecorationType.underlined,
            ),
            const SizedBox(height: 20),
            ReadyInput(
              hint: 'Enter your name',
              label: "Name",
              controller: controller,
              decorationType: InputDecorationType.outlined,
            ),
            const SizedBox(height: 20),
            ReadyPhoneInput(
              initialDialCode: "+92",
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              onCountryChange: (value) {
                print(value.dialCode);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ReadyBottomBar(
        child: Row(
          children: [
            ReadyLikeButton.outlined(isLiked: true),
            const SizedBox(width: 8),
            Expanded(
              child: ReadyTextButton.solid(
                text: "Submit",
                width: double.infinity,
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
