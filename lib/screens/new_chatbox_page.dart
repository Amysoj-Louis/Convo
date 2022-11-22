import 'package:convo/screens/chatbox_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NewChatBox extends StatefulWidget {
  const NewChatBox({super.key});

  @override
  State<NewChatBox> createState() => _NewChatBoxState();
}

class _NewChatBoxState extends State<NewChatBox> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
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
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "Start New Convo",
              style: TextStyle(color: Colors.white, fontSize: 70),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: title,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Title",
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextField(
              controller: content,
              maxLines: 5,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "First Message",
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 20, right: 20, bottom: 50),
            child: GestureDetector(
              onTap: () {
                if (title.text.isNotEmpty && content.text.isNotEmpty) {
                  FirebaseDatabase.instance
                      .ref(title.text)
                      .push()
                      .set(content.text);
                  FirebaseDatabase.instance.ref("Chats").push().set({
                    "Title": title.text,
                    "Latest_Message": content.text
                  }).then((value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => Chatbox(title: title.text))));
                } else if (title.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter Title of Convo",
                        style: TextStyle(fontFamily: "Gugi"),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  );
                } else if (content.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter First Message of Convo",
                        style: TextStyle(fontFamily: "Gugi"),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
