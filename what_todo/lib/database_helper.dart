import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:what_todo/widgets.dart';
import 'authentication.dart';
import 'dart:core';
import 'task.dart';
import 'taskpage.dart';
import 'todo.dart';



class DatabaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  String title = "hey man";
  //int i = 0;
  final List<TaskCardWidget> data = <TaskCardWidget>[];
  //get user => _auth.currentUser;
  //get uid => user.uid;
  late UserCredential user;
  static String uid = "123";
  List<Task> tasklist = [];
  Future signUp({required String email, required String password}) async {
    try {
      user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // DatabaseReference mDatabase = FirebaseDatabase.instance.ref();
      //  mDatabase.child("users").child(user.uid).set("hello world");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

  }
  Future signIn({required String email, required String password}) async {
    try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    // print(uid);
    // print(email);
    // print(password);
    return null;
    } on FirebaseAuthException catch (e) {
    return e.message;
    }
  }
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  insertTask(Task task) async {
    tasklist.add(task);
    DatabaseReference _db1 = FirebaseDatabase.instance.ref(
      "users"
    );
    String currentuser = _auth.currentUser!.uid;
    _db1.child(currentuser).child('tasks').push().set(task.toMap());
  }

  void saveMessage(Task message) {
    _db.push().set(message.toMap());
  }

  Query getMessageQuery() {
    return _db;
  }

  List<TaskCardWidget> getValue() {

    String currentuser = _auth.currentUser!.uid;
    DatabaseReference _db1 = FirebaseDatabase.instance.ref(
        "users"
    );
    var ref = _db1.child(currentuser).child('tasks');
    ref.onValue.listen((event) {
      //i = 0;
      int x = event.snapshot.children.length;
      data.clear();
      for (int i = 0; i < x; i++){
        title = event.snapshot.children.elementAt(i).value.toString();
        data.insert(i, (TaskCardWidget(
                 title
             )));
        // data[i] = (TaskCardWidget(
        //     title
        // ));
      };
    });
    return data;
  }

  getTasks() async {
    DatabaseReference _db1 = FirebaseDatabase.instance.ref(
        "users"
    );
    print("we made it here");
    String currentuser = _auth.currentUser!.uid;
    Task thefirst = Task(title: "start");
    var newKey = _db1.child(currentuser).child('tasks').push();
    String newerKey = newKey.key.toString();
    print(newerKey);
    _db1.child(currentuser).child('tasks').child(newerKey).set(thefirst.toMap());
    _db1.child(currentuser).child('tasks').child(newerKey).remove();
  }

  //
  // Future<List<Todo>> getTodo(int taskId) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
  //   return List.generate(todoMap.length, (index) {
  //     return Todo(id: todoMap[index]['id'], title: todoMap[index]['title'], taskId: todoMap[index]['taskId'], isDone: todoMap[index]['isDone']);
  //   });
  // }
  //
  // Future<void> updateTodoDone(int id, int isDone) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  // }
  //
  // Future<void> deleteTask(int id) async {
  //   Database _db = await database();

  //   await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
  //   await _db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
  // }
  }



