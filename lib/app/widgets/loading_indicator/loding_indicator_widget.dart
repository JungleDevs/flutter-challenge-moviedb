import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LodingIndicatorWidget extends StatelessWidget {
  const LodingIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets6.lottiefiles.com/packages/lf20_vqa0ahvi.json',
              height: 56,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text('Loading...',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
