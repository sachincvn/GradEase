import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/profile/presentation/widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(StringConstants.avtarImage),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Sachin Chavan",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "sachin@example.com",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [
                      ColorPallete.green500,
                      ColorPallete.blue500,
                      ColorPallete.blue700,
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPallete.transparentColor,
                    shadowColor: ColorPallete.transparentColor,
                  ),
                  child: Text(
                    "Edit Profile",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: ColorPallete.grey400, height: .1),
              const SizedBox(height: 40),
              const ProfileMenuWidget(
                  title: "Settings", leadingIcon: Icon(Icons.settings)),
              const ProfileMenuWidget(
                  title: "Feedback", leadingIcon: Icon(Icons.settings)),
              const ProfileMenuWidget(
                  title: "Share app", leadingIcon: Icon(Icons.settings)),
              const Divider(color: ColorPallete.grey400, height: .1),
              const ProfileMenuWidget(
                  title: "About", leadingIcon: Icon(Icons.settings)),
              const ProfileMenuWidget(
                title: "Logout",
                leadingIcon: Icon(Icons.logout_rounded),
                textColor: Colors.red,
                trailingIcon: Icon(null),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
