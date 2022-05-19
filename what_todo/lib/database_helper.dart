import 'dart:collection';

import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'task.dart';
import 'todo.dart';



class DatabaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  //get user => _auth.currentUser;
  //get uid => user.uid;
  late UserCredential user;
  static String uid = "123";
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

  Future<int> insertTask(Task task) async {
    DatabaseReference _db1 = FirebaseDatabase.instance.ref();
    String currentuser = _auth.currentUser!.uid;
    //_db1.child("list").child(currentuser).child('tasks').key!;
   // Map<String, Object> map = new HashMap<>() as Map<String, Object>;
   // map.put(key, "comment5");
    int taskId = 0;
    //var myRef = _db1.child("users").child(uid).child('tasks').push();
   // myRef.set(task.toMap());
    _db1.child("list").child(currentuser).child('tasks').update(task.toMap());
    //  update(task.toMap(), key);
    // String key = rootRef.child("list").child(list_id).push().getKey();
    // Map<String, Object> map = new HashMap<>();
    // map.put(key, "comment5");
    // rootRef.child("list").child(list_id).updateChildren(map);
    // conflictAlgorithm: ConflictAlgorithm.replace).then((value); if data conflicts replace

    // Database _db = await database();
    // await _db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
    //   taskId = value;
    // });
    return taskId;
  }

  // Future<void> updateTaskTitle(int id, String title) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  // }
  //
  // Future<void> updateTaskDescription(int id, String description) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE tasks SET description = '$description' WHERE id = '$id'");
  // }
  //
  // Future<void> insertTodo(Todo todo) async {
  //   Database _db = await database();
  //   await _db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  Future<List<Task>> getTasks() async {
    print("Hi");
    List<Map<String, dynamic>> taskMap = (await FirebaseDatabase.instance.ref("tasks") as List<Map<String, dynamic>>);
    print(taskMap.length);
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']
      );
    });
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



