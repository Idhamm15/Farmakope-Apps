import 'package:flutter/material.dart';
import '../theme.dart';

class ItemTanaman extends StatelessWidget {
  const ItemTanaman({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 100,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: medium,
                  color: cDarkGrenn,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Tanaman Herbal',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: light,
                  color: cGray,
                  letterSpacing: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
