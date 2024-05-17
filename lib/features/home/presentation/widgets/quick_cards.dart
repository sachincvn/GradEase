import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuickCards extends StatelessWidget {
  const QuickCards({
    super.key,
    required this.context,
    required this.cardColor,
    required this.textColor,
    required this.labelName,
    required this.lottieAssest,
    this.onTap,
  });

  final BuildContext context;
  final Color cardColor;
  final Color textColor;
  final String labelName;
  final String lottieAssest;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 125,
          margin: const EdgeInsets.only(left: 7, right: 7),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset(lottieAssest,
                  height: 80, width: 80, fit: BoxFit.contain),
              Text(
                labelName,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
