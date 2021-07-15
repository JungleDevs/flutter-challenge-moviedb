import 'package:flutter/material.dart';

class MovieRatingWidget extends StatelessWidget {
  final double rating;
  final bool _topMovie;
  MovieRatingWidget({Key? key, required this.rating, bool? topMovie})
      : _topMovie = topMovie ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: _topMovie ? Color(0xFF1F8CFF) : Color(0xFF252634),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 3,
                ),
                child: Icon(
                  index >= rating.ceil() ~/ 2 ? Icons.star_border : Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 6,
              ),
              child: Text(
                '${rating.ceil() ~/ 2}/5',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFCCE5FF),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
