import 'package:flutter/material.dart';

import '../screens/chatbox_page.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Chatbox(title: title)));
        },
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
