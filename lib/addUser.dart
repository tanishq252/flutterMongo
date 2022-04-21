import 'package:flutter/material.dart';
import 'package:flutter_mongo/database.dart';
import 'package:flutter_mongo/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
// import 'package:mongo_dart/database.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _age;
  var h, w;

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController(text: "");
    _age = TextEditingController(text: "");
    _phone = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent)),
            margin: EdgeInsets.all(w / 30),
            padding: EdgeInsets.all(w / 20),
            child: Column(
              children: [
                Container(
                  height: h / 100,
                ),
                TextField(
                  controller: _name,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixText: 'Name : ',
                    labelText: 'Name : ',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(w / 60),
                  ),
                ),
                Container(
                  height: h / 100,
                ),
                TextField(
                  autofocus: true,
                  controller: _age,
                  decoration: InputDecoration(
                    prefixText: 'Age : ',
                    labelText: 'Age : ',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(w / 60),
                  ),
                ),
                Container(
                  height: h / 100,
                ),
                TextField(
                  controller: _phone,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixText: 'Phone : ',
                    labelText: 'Phone : ',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: EdgeInsets.all(w / 60),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: h / 3,
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              color: Colors.blue,
              width: w / 3,
              height: h / 20,
              child: Center(child: Text("Add User")),
            ),
            onTap: () {
              createUser().then((value)=>showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  'User added',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK', textAlign: TextAlign.center),
                  ),
                ],
              )));
            },
          )
        ],
      ),
    );
  }

  createUser() async {
    final user = User(
        id: M.ObjectId(),
        name: _name.text,
        age: int.parse(_age.text),
        phone: int.parse(_phone.text));
    await MongoDatabase.insert(user);
  }

  updateUser(User user) async {
    final newU = User(
        id: user.id,
        name: _name.text,
        age: int.parse(_age.text),
        phone: int.parse(_phone.text));
    await MongoDatabase.update(user);
  }

  trial() {
    print("ghgh");
  }
}
