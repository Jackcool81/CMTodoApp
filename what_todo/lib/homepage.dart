import 'package:flutter/material.dart';
import 'package:what_todo/database_helper.dart';
import 'package:what_todo/task.dart';
import 'taskpage.dart';
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
                    child: FutureBuilder( //This allows us to scroll through tasks
                    initialData: [],
                    future: _db.getTasks(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        x = snapshot.data.length;
                      }
                      else {
                        x = 0;
                      }
                      print(x);
                      return ListView.builder(
                        itemCount: x,
                        itemBuilder: (context, index) {
                        return TaskCardWidget(
                          title: snapshot.data[index].title,

                        );
                          },
                        //var data = (snapshot.data as List<Task>).toList(),

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
        ),
      ),
    ));
  }
}
