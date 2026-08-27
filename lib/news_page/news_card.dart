import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget{
  final String heading;
  final String anonsText;
  final Widget image;
  final VoidCallback onTap;

  const NewsCard({super.key, required this.heading, required this.anonsText, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF4EABC7),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      anonsText,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                    padding: EdgeInsets.all(5),
                child: image),
              ),
            )
          ],
        ),
      ),
    );
  }
}