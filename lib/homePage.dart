import 'package:flutter/material.dart';
import 'package:flutter_mongo/updateUser.dart';
// import 'package:mongo_dart/mongo_dart.dart';

import 'addUser.dart';
import 'contactComponent.dart';
import 'database.dart';
import 'models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> sm;
  late List<String> names = [];

  void getData() async {
    await MongoDatabase.getDocs().forEach((c) => {print(c.toString())});
  }

  var h, w, s;
  @override
  Widget build(BuildContext context) {
    s = MediaQuery.of(context).size;
    h = s.height;
    w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management System"),
      ),
      body: ListView(

        children: <Widget>[
          Container(
            height: h / 30,
          ),
          IconButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddUser()));
              },
              icon: Icon(
                Icons.person_add_alt_sharp,
                size: h / 20,
              )),
          Container(
            height: h / 50,
          ),
          FutureBuilder(
              future: MongoDatabase.getDocuments(),
              builder: (buildContext, AsyncSnapshot snapshot) {
                sm = snapshot.data as List<Map<String, dynamic>>;
                if (snapshot.hasError) {
                  return Text("Loading");
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: Text("Waiting..."),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SizedBox(
                        height: h / 1.3,
                        child: ListView.builder(
                            itemCount: sm.length,
                            itemBuilder: (context, index) {
                              return UserCard(user: sm[index]);
                            })),
                  );
                }
              }),
          // ////////////////////////////////////////////////////////////////////////////////////////////////
          // second method for reading data from mongo db
          // FutureBuilder(
          //     future: MongoDatabase.getDocuments(),
          //     builder: (context, snapshot) {
          //       // setState(() {
          //       sm = snapshot.data as List<Map<String, dynamic>>;
          //       // });
          //       print(sm.length);
          //       for (int i = 0; i < sm.length; i++) {
          //         print(sm[i]["phone"].toString());
          //         names.add(sm[i]["phone"].toString());
          //       }
          //       return Text("data");
          //     }),

          // for (int i = 0; i < names.length/2; i++) Text(names[i])
          // ////////////////////////////////////////////////////////////////////////////////////////////////
        ],
      ),
    );
  }
}

