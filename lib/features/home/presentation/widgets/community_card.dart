import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
    required this.title,
    required this.description,
    required this.groupImageUrl,
  });

  final String title;
  final String description;
  final String groupImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xFF313a4d),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorPallete.grey400,
                    maxRadius: 35,
                    child: Image.network(
                      fit: BoxFit.cover,
                      height: 50,
                      groupImageUrl,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "112 memebers",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Join",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ))
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
