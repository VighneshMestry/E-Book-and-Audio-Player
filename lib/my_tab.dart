import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
  final Color color;
  final String text;
  const AppTab({super.key,required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 50,
      // ignore: sort_child_properties_last
      child: Text(
        this.text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
