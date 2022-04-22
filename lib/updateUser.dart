import 'package:flutter/material.dart';
import 'package:flutter_mongo/database.dart';
import 'package:flutter_mongo/homePage.dart';
import 'package:flutter_mongo/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
// import 'package:mongo_dart/database.dart';

class UpdateUser extends StatefulWidget {
  final M.ObjectId id;
  // final User u;
  const UpdateUser({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController _name = TextEditingController(text: "");
  late TextEditingController _phone = TextEditingController(text: "");
  late TextEditingController _age = TextEditingController(text: "");
  var h, w;
  late Map<String, dynamic> use;
  late User u;

  @override
  void initState() {
    print(widget.id);
    initializeUser();
  }

  void initializeUser() async {
    use = await MongoDatabase.currentuser(widget.id);
    setState(() {
      _name = TextEditingController(text: use["name"]);
      _age = TextEditingController(text: use["age"].toString());
      _phone = TextEditingController(text: use["phone"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
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
                  height: h / 50,
                ),
                TextField(
                  autofocus: true,
                  controller: _age,
                  keyboardType: TextInputType.number,
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
                  height: h / 50,
                ),
                TextField(
                  controller: _phone,
                  autofocus: true,
                  keyboardType: TextInputType.number,
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
            height: h / 30,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              width: w / 3,
              height: h / 20,
              child: Center(child: Text("Update User")),
            ),
            onTap: () async {
              setState(() {
                u = User(
                    id: widget.id,
                    name: _name.text,
                    age: int.parse(_age.text),
                    phone: int.parse(_phone.text));
              });

              await MongoDatabase.update(u);
              await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'User updated!!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage())),
                            child:
                                const Text('OK', textAlign: TextAlign.center),
                          ),
                        ],
                      ));
              // }
            },
          )
        ],
      ),
    );
  }
}
