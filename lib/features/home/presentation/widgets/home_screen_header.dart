import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

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
                child: Image.network(
                    height: 55,
                    fit: BoxFit.cover,
                    "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1"),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Sachin !",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "welcome to gradeease",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
        ],
      ),
    );
  }
}
