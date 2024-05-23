import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class HomeScreenHeader extends StatelessWidget {
  final String studentName;
  final String? profileImageUrl;

  const HomeScreenHeader({
    Key? key,
    required this.studentName,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 14, right: 14, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: ColorPallete.transparentColor,
                minRadius: 28,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(
                        "${RestResources.imageBaseUrl}$profileImageUrl")
                    : NetworkImage(
                        "${RestResources.imageBaseUrl}${StringConstants.defaultAvatar}"),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ${getFirstName(studentName)} !",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Welcome to GradeEase",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.refresh))
        ],
      ),
    );
  }

  String getFirstName(String fullName) {
    try {
      return fullName.split(' ').first;
    } catch (e) {
      return fullName;
    }
  }
}
