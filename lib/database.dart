import 'package:mongo_dart/mongo_dart.dart';

import 'models/user.dart';

class MongoDatabase {
  static var db, collection, coll;

  // function to connect the database
  static connect() async {
    // connection to mongodb
    db = await Db.create(
        "mongodb+srv://tanishq777:tanishq777@cluster0.lzgyb.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
    // open the database for changes
    await db.open();
    // fetch the collection we want
    collection = db.collection("User");
  }

  // function to insert the data
  // this is the create function of the app
  static insert(User user) async {
    await collection.insertAll([user.toMap()]);
  }

  // this function is to read the data from db
  // tom read all the documents we need to use the find() function
  static Future<List<Map<String, dynamic>>?> getDocuments() async {
    try {
      final users = await collection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static getUsers() async {
    var usersList = await collection.find({}).toList();
    print(usersList);
    return usersList;
  }

  static getDocs() async {
    final users = await collection.find();
    return users;
  }

  // to find any desired user using user's id we use findOne() method of mongo db
  // further to make changes of the updated data we use save() function
  static update(User user) async {
    var currentUser = await collection.findOne({"_id": user.id});
    currentUser["name"] = user.name;
    currentUser["age"] = user.age;
    currentUser["phone"] = user.phone;
    await collection.save(currentUser);
  }

  // deletion operations are often easy to perform
  static delete(User user) async {
    await collection.remove(where.id(user.id));
  }

  static deleteUser(ObjectId id) async {
    await collection.remove(where.id(id));
  }

  static currentuser(ObjectId id) {
    return collection.findOne({"_id": id});
  }
}
