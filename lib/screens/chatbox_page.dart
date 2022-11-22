import 'package:convo/screens/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_listtlie2.dart';

class Chatbox extends StatefulWidget {
  const Chatbox({super.key, required this.title});
  final String title;
  @override
  State<Chatbox> createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  TextEditingController message = TextEditingController();
  List data = [];
  int limitamt = 20;
  getdata2() {
    setState(
      () {
        data = [];
      },
    );
    setState(() {
      final ref = FirebaseDatabase.instance.ref();
      ref
          .child(widget.title)
          .limitToLast(limitamt)
          .onChildAdded
          .listen((event) {
        final snapshot = event.snapshot;
        if (snapshot.exists) {
          data.add(snapshot.value);
        }
      });
    });
  }

  getdata() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(widget.title).limitToLast(limitamt).get();

    if (snapshot.exists) {
      setState(
        () {
          final mydata =
              Map<Object, Object>.from(snapshot.value as Map<dynamic, dynamic>);
          mydata.forEach(
            (key, value) {
              print(value);
              data.add(value);
            },
          );
        },
      );
    }
  }

  @override
  void initState() {
    getdata();
    getdata2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1), fontSize: 30),
          ),
          leadingWidth: 60,
          leading: Container(
            width: 60,
            alignment: Alignment.center,
            child: IconButton(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
          actions: [
            IconButton(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                  size: 25,
                ))
          ],
        ),
        body: Column(children: [
          Expanded(
              child: ListView(
            reverse: true,
            children:
                data.reversed.map((e) => CustomListTile2(text: e)).toList(),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: message,
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                  suffixIconConstraints: const BoxConstraints(maxWidth: 60),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (message.text.isNotEmpty) {
                        FirebaseDatabase.instance.ref(widget.title).push().set({
                          "message": message.text,
                          "time": ServerValue.timestamp
                        }).then((value) => message.clear());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("images/Send.png"),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2))),
            ),
          )
        ]),
      ),
    );
  }
}
