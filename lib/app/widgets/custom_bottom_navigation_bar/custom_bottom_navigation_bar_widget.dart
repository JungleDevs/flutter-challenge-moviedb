import 'package:flutter/material.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  final List<IconData> iconList;
  const CustomBottomNavigationBarWidget({Key? key, required this.iconList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: BottomNavigationBar(
          currentIndex: 1,
          elevation: 0,
          selectedItemColor: Color(0xFF1F8CFF),
          selectedFontSize: 0,
          items: List.generate(iconList.length, (index) {
            return BottomNavigationBarItem(
              label: '',
              icon: Icon(iconList[index]),
              backgroundColor: Color(0xFF1B1C2A),
            );
          })),
    );
  }
}
