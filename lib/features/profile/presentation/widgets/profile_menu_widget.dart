import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class ProfileMenuWidget extends StatelessWidget {
  final Icon leadingIcon;
  final Icon? trailingIcon;
  final Color? textColor;
  final String title;
  const ProfileMenuWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.trailingIcon = const Icon(Icons.chevron_right_outlined),
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorPallete.grey400,
        ),
        child: leadingIcon,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500, color: textColor),
      ),
      trailing: IconButton(onPressed: () {}, icon: trailingIcon!),
    );
  }
}
