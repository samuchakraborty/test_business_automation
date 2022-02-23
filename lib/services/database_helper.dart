import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_business_automation_ltd/model/user_model.dart';

class DBHelper {
  late Database _db;
  static const String id = 'id';
  static const String userName = 'userName';
  static const String url = 'url';
  static const String mobileNumber = 'mobileNumber';

  //for user LOGIN AND REGISTRATION
  static const String userTable = 'user';
  static const String userDbName = 'user.db';

  // //STORE DATA
  // static const String USER_STORE_TABLE = 'storeData';
  // static const String STORE_ID = 'id';
  // static const String USER_STORE_TIMESTAMP = 'timestamp';
  // static const String USER_STORE_VALUE = 'storeValue';
  // static const String USER_SEARCH_BY_VALUE= 'searchByValue';
  // static const String USER_SEARCH_RESULT= 'result';

  Future<Database> get db async {
    // if (_db != null) {
    //   return _db;
    // }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, userDbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $userTable ($id INTEGER PRIMARY KEY autoincrement, $userName TEXT, $url TEXT, $mobileNumber TEXT)");

    // await db.execute(
    //     "CREATE TABLE $USER_STORE_TABLE ($STORE_ID INTEGER, $USER_STORE_VALUE TEXT, $USER_SEARCH_BY_VALUE TEXT, $USER_STORE_TIMESTAMP TEXT, $USER_SEARCH_RESULT TEXT )");

    await db.transaction((txn) async {
      var query =
          "INSERT INTO $userTable ($userName, $url, $mobileNumber) VALUES ('Samu Chakrabory ','https://www.github.com', '01851944605')";
      print(query);
      int lastId = await txn.rawInsert(query);
      print(lastId);

      return lastId;
    });
    await db.transaction((txn) async {
      var query =
          "INSERT INTO $userTable ($userName, $url, $mobileNumber) VALUES ('Samu John ', 'https://www.facebook.com', '01819632199')";
      print(query);
      int lastId = await txn.rawInsert(query);
      print(lastId);

      return lastId;
    });
    await db.transaction((txn) async {
      var query =
          "INSERT INTO $userTable ($userName, $url, $mobileNumber) VALUES ('Samu Chakrabory ', 'https://www.linkedin.com', '01751944605')";
      print(query);
      int lastId = await txn.rawInsert(query);
      print(lastId);

      return lastId;
    });
    await db.transaction((txn) async {
      var query =
          "INSERT INTO $userTable ($userName, $url, $mobileNumber) VALUES ('Samu Chakrabory ','https://www.youtube.com', '01651944605')";
      print(query);
      int lastId = await txn.rawInsert(query);
      print(lastId);

      return lastId;
    });


  }

  Future storeData(UserList user) async {
    var dbClient = await db;
    int id = await dbClient.insert(userTable, user.toStore());
    print(id);
    return id;
    //var query;
    // await dbClient.transaction((txn) async {
    //   var query =
    //       "INSERT INTO $USER_TABLE ($USER_NAME, $USER_MOBILE, $USER_PASSWORD) VALUES ('" +
    //           userName +
    //           "', '" +
    //           mobile +
    //           "', '" +
    //           password +
    //           "')";
    //   print(query);
    //   int lastId = await txn.rawInsert(query);
    //   print(lastId);
    //
    //   return lastId;
    // });
  }

  // Future<List<UserList>?> getAllStoreDataById({id}) async {
  //   var dbClient = await db;
  //   // List<Map<String, dynamic>> mapss = await dbClient.query(USER_STORE_TABLE,
  //   //     columns: [STORE_ID, USER_STORE_VALUE, USER_SEARCH_BY_VALUE, USER_STORE_TIMESTAMP]);
  //   //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
  //   // List user = [];
  //   // if (mapss.length > 0) {
  //   //   for (int i = 0; i < mapss.length; i++) {
  //   //     //user.add(User(mapss![i]));
  //   //     print(mapss[i]);
  //   //   }
  //   // }
  //
  //   var result =
  //   await dbClient.query(USER_STORE_TABLE, where: "id=?", whereArgs: [id]);
  //   // return User.fromMap(result.first);
  //   print(result);
  //
  //   //  StoreData.fromMap(result);
  //   List<StoreData>? list =
  //   result.isNotEmpty ? result.map((c) => StoreData.fromMap(c)).toList() : null;
  //
  //
  //
  //   return list;
  //   // return List.generate(result.length, (i) {
  //   //   return StoreData(
  //   //       id: result[i]['id'],
  //   //       timestamp: result[i]['timestamp'],
  //   //       storeValue: result[i]['storeValue'],
  //   //       searchByValue: result[i]['searchByValue']);
  //   // });
  //
  //   // return user;
  // }
  //
  //
  //
  //
  //
  //
  // Future signUpUser(User user) async {
  //   var dbClient = await db;
  //   int id = await dbClient.insert(USER_TABLE, user.toUser());
  //   print(id);
  //   return id;
  //   //var query;
  //   // await dbClient.transaction((txn) async {
  //   //   var query =
  //   //       "INSERT INTO $USER_TABLE ($USER_NAME, $USER_MOBILE, $USER_PASSWORD) VALUES ('" +
  //   //           userName +
  //   //           "', '" +
  //   //           mobile +
  //   //           "', '" +
  //   //           password +
  //   //           "')";
  //   //   print(query);
  //   //   int lastId = await txn.rawInsert(query);
  //   //   print(lastId);
  //   //
  //   //   return lastId;
  //   // });
  // }

  Future<List<UserList>> getAllUser() async {
    var dbClient = await db;
    List<Map<String, dynamic>> mapss = await dbClient
        .query(userTable, columns: [id, userName, url, mobileNumber]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    // List user = [];
    // if (mapss.length > 0) {
    //   for (int i = 0; i < mapss.length; i++) {
    //     //user.add(User(mapss![i]));
    //     print(mapss[i]);
    //   }
    // }
    return List.generate(mapss.length, (i) {
      return UserList(
          id: mapss[i]['id'],
          userName: mapss[i]['userName'],
          url: mapss[i]['url'],
          mobileNumber: mapss[i]['mobileNumber']);
    });

    // return user;
  }

  //
  // Future<User?> getUser({required int lastId}) async {
  //   var dbClient = await db;
  //   // List<Map> mapss = await dbClient.query(USER_TABLE,
  //   //     columns: [ID, USER_NAME, USER_PASSWORD, USER_MOBILE]);
  //   // //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
  //   // List<User> user = [];
  //   // if (mapss.length > 0) {
  //   //   for (int i = 0; i < mapss.length; i++) {
  //   //     //user.add(User(mapss![i]));
  //   //     print(mapss[i]);
  //   //   }
  //   // }
  //
  //   var result =
  //   await dbClient.query(USER_TABLE, where: "id=?", whereArgs: [lastId]);
  //   return User.fromMap(result.first);
  //
  //   //return user;
  // }
  //
  // Future<User?> loginUser({required mobile, required password}) async {
  //   var dbClient = await db;
  //
  //   var result = await dbClient.rawQuery(
  //       "SELECT * FROM $USER_TABLE WHERE mobile = '$mobile' and password = '$password'");
  //
  //   //var result = await dbClient.query(USER_TABLE, where: "id=?", whereArgs: [lastId]);
  //   print(result);
  //   return result.length != 0 ? User.fromMap(result.first) : null;
  //
  //   //return user;
  // }
  //
  // // Future<int> delete(int id) async {
  // //   var dbClient = await db;
  // //   return await dbClient.delete(USER_TABLE, where: '$ID = ?', whereArgs: [id]);
  // // }
  //
  // // Future<int> update(User employee) async {
  // //   var dbClient = await db;
  // //   return await dbClient.update(USER_TABLE, employee.toMap(),
  // //       where: '$ID = ?', whereArgs: [employee.id]);
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
