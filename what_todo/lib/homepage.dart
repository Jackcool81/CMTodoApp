import 'package:flutter/material.dart';
import 'package:what_todo/database_helper.dart';
import 'package:what_todo/task.dart';
import 'taskpage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../widgets.dart';
import 'package:firebase_core/firebase_core.dart';



class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  DatabaseHelper _db = DatabaseHelper();
  int x = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 32.0,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image: AssetImage('assests/images/logo.png')),
                Expanded(
                      child: FirebaseAnimatedList(
                        query: _db.getMessageQuery(),
                        itemBuilder: (context, snapshot, animation, index) {
                          final json = snapshot.value as Map<dynamic, dynamic>;
                          final message = Task.fromJson(json);
                            return TaskCardWidget(
                              message.title
                            );
                          },
    ),
                      ),
    ],
    ),
            Positioned( //this is our add task button that takes us to the taskpage
              bottom: 24.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Taskpage()),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image(
                    image: AssetImage(
                      "assests/images/add_icon.png",
                    ),
                  ),
    ),
          ),
        ),
    ],
    )
    )
        )
    );
  }
}
