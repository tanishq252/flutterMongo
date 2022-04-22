import 'package:flutter/material.dart';
import 'package:flutter_mongo/updateUser.dart';

import 'database.dart';
import 'homePage.dart';
import 'models/user.dart';

class UserCard extends StatefulWidget {
  final Map<String, dynamic> user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late User u;
  var h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(w/30, h/50, w/30, 0),
      height: h/8,
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(w/20,h/50, 0,0),
                  child: Text(widget.user["name"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                Container(
                  margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                  child: Text('Age: ${widget.user["age"]}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),),
                Container(
                  margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                  child: Text('Phone: ${widget.user["phone"]}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),),
              ],
            ),
          ),
          // Container(width: w/3,),
          Container(
            margin: EdgeInsets.fromLTRB(0,0,w/30,0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Icon(Icons.edit),
                onTap: () {
                  {
                    print(widget.user["_id"].toString());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateUser(id: widget.user["_id"]))).then((value) => setState(() {}));;
                  }
                },
              ),

              GestureDetector(
                child: Icon(Icons.delete),
                onTap: () async {
                  await MongoDatabase.deleteUser(widget.user["_id"]);
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'User deleted successfully!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage())),
                              child:
                                  const Text('OK', textAlign: TextAlign.center),
                            ),
                          ],
                        ));
                },
              ),
            ],
        ),
          ),
        ],
      ),
    );

    // return Material(
    //   elevation:3.0,
    //   color: Colors.white,
    //   child: ListTile(
    //     title: Text(widget.user["name"], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    //     subtitle: Text('\nPhone: ${widget.user["phone"]}\nAge: ${widget.user["age"]}'),
    //     trailing: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         GestureDetector(
    //           child: Icon(Icons.edit),
    //           onTap: () {
    //             {
    //               print(widget.user["_id"].toString());
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => UpdateUser(id: widget.user["_id"]))).then((value) => setState(() {}));;
    //             }
    //           },
    //         ),

    //         GestureDetector(
    //           child: Icon(Icons.delete),
    //           onTap: () async {
    //             await MongoDatabase.deleteUser(widget.user["_id"]);
    //             await showDialog(
    //               context: context,
    //               builder: (BuildContext context) => AlertDialog(
    //                     backgroundColor: Colors.white,
    //                     title: const Text(
    //                       'User deleted successfully!!!',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(color: Colors.black),
    //                     ),
    //                     actions: <Widget>[
    //                       TextButton(
    //                         onPressed: () => Navigator.pushReplacement(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     HomePage())),
    //                         child:
    //                             const Text('OK', textAlign: TextAlign.center),
    //                       ),
    //                     ],
    //                   ));
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  void getUser() async {
    u = await MongoDatabase.currentuser(widget.user["_id"]);
  }
}
