import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class ClockInCard extends StatelessWidget {
  const ClockInCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6d61f3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                backgroundColor: const Color(0xFF8c85f6),
                side: const BorderSide(color: ColorPallete.transparentColor),
                label: Text(
                  "Today : 02/04/2024",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Chip(
                backgroundColor: const Color(0xFF8c85f6),
                side: const BorderSide(color: ColorPallete.transparentColor),
                label: Text(
                  "Clock-In",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "10:30 - 11:30",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Computer Science",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: Image.network(
                    "https://cdn-icons-png.freepik.com/512/5832/5832416.png?filename=stack-books_5832416.png&fd=1"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
