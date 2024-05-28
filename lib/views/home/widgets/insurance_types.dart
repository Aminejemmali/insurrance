import 'package:flutter/material.dart';

class InsurranceTypeWidget extends StatelessWidget {
  final String image_url;
  final String title;
  final String description;
  final VoidCallback onclick;

  const InsurranceTypeWidget({
    required this.image_url,
    required this.title,
    required this.description,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image_url, width: 80, height: 80),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
