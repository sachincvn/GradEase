import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:lottie/lottie.dart';

class OnGoingClassWidget extends StatelessWidget {
  const OnGoingClassWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6d61f3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Good Morning",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Cloud Computing",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "10:30 - 11:30",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Lottie.asset(
            LocalResourcesConstants.studyLottie,
            height: 110,
            width: 120,
          ),
        ],
      ),
    );
  }
}
