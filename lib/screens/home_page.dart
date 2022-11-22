import 'package:convo/widgets/custom_listtile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'new_chatbox_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  List data = [];
  getdata() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Chats").get();
    setState(
      () {
        data = [];
      },
    );
    if (snapshot.exists) {
      setState(
        () {
          final mydata =
              Map<Object, Object>.from(snapshot.value as Map<dynamic, dynamic>);
          mydata.forEach(
            (key, value) {
              final v =
                  Map<Object, Object>.from(value as Map<dynamic, dynamic>);
              data.add([v["Title"], v["Latest_Message"]]);
            },
          );
        },
      );
    }
  }

  @override
  void initState() {
    getdata();
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
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewChatBox()),
            );
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.add,
              size: 60,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              "Convo",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: search,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: "Search",
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 40),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset("images/Search.png"),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
                children: data
                    .map(
                      (e) => CustomListTile(title: e[0], subtitle: e[1]),
                    )
                    .toList()),
          ),
        ]),
      ),
    );
  }
}
