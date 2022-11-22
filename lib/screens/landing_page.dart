import 'package:flutter/material.dart';
import 'home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  changepage() async {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  void initState() {
    changepage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.topCenter,
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomRight,
                image: AssetImage(
                  "images/bg.png",
                ))),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text("Convo",
              style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 90)),
        ),
      ),
    );
  }
}
