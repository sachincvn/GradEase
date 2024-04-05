import 'package:flutter/material.dart';

class QuickCards extends StatelessWidget {
  const QuickCards({
    super.key,
    required this.context,
    required this.cardColor,
    required this.textColor,
    required this.labelOne,
    required this.labelTwo,
    required this.labelThree,
    required this.imageUrl,
  });

  final BuildContext context;
  final Color cardColor;
  final Color textColor;
  final String labelOne;
  final String labelTwo;
  final String labelThree;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 115,
        margin: const EdgeInsets.only(left: 7, right: 7),
        padding: const EdgeInsets.only(top: 10, left: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              labelOne,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      labelTwo,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      labelThree,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                  ],
                ),
                Image.network(
                  imageUrl,
                  height: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
