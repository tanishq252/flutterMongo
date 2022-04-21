import 'package:flutter/material.dart';
import 'package:flutter_mongo/updateUser.dart';
// import 'package:mongo_dart/mongo_dart.dart';

import 'addUser.dart';
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
        title: Text("Read Data"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: h / 30,
          ),
          IconButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUser()));
              },
              icon: Icon(
                Icons.person_add_alt_sharp,
                size: h / 20,
              )),
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
                        height: h/1.5,
                        child: ListView.builder(
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return UserCard(user: sm[index]);
                            })),
                  );
                }
              }),
          // ////////////////////////////////////////////////////////////////////////////////////////////////

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

class DocumentSnapshot {}

class UserCard extends StatelessWidget {
  const UserCard({required this.user});
  final Map<String, dynamic> user;
  // final Function onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          '${user["age"]}',
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(user["name"]),
        subtitle: Text('${user["phone"]}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              // onTap: (){
              //   {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => UpdateUser(id:user["id"])));
              // }
              // },
              onTap: () async {
                await MongoDatabase.updateUser(user["_id"]);
              },
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                await MongoDatabase.deleteUser(user["_id"]);
              },
            ),
          ],
        ),
      ),
    );
  }


}
