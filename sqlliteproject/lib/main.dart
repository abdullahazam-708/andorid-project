import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.instance.database;
  runApp(DBApp());
}

class DBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// ================= USER MODEL =================
class User {
  final int? userId;
  final String username;
  final String userEmail;
  final String userPassword;

  User({
    this.userId,
    required this.username,
    required this.userEmail,
    required this.userPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      username: map['username'],
      userEmail: map['userEmail'],
      userPassword: map['userPassword'],
    );
  }
}

// ================= DB HELPER =================
class DBHelper {
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _db;

  Future<Database> get database async =>
      _db ??= await _initDB();

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "user.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        userEmail TEXT,
        userPassword TEXT
      )
    ''');
  }

  Future<int> insertUser(User u) async {
    Database db = await instance.database;
    return await db.insert('user', u.toMap());
  }

  Future<List<User>> searchUser() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> uList =
    await db.query("user");

    return List.generate(
      uList.length,
          (i) => User.fromMap(uList[i]),
    );
  }

  Future<int> updateUser(User u) async {
    Database db = await instance.database;

    return await db.update(
      "user",
      u.toMap(),
      where: 'userId = ?',
      whereArgs: [u.userId],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;

    return await db.delete(
      "user",
      where: 'userId = ?',
      whereArgs: [id],
    );
  }
}

// ================= UI =================
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  User? selectedUser;

  void clearFields() {
    txtName.clear();
    txtEmail.clear();
    txtPassword.clear();
    selectedUser = null;
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite CRUD"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            // ================= INPUT FIELDS =================
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: txtEmail,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: txtPassword,
              decoration: InputDecoration(labelText: "Password"),
            ),

            SizedBox(height: 20),

            // ================= BUTTONS =================
            Row(
              children: [

                ElevatedButton(
                  onPressed: () async {
                    User u = User(
                      username: txtName.text,
                      userEmail: txtEmail.text,
                      userPassword: txtPassword.text,
                    );

                    await DBHelper.instance.insertUser(u);

                    clearFields();
                    refresh();
                  },
                  child: Text("Add"),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: selectedUser == null
                      ? null
                      : () async {
                    User updated = User(
                      userId: selectedUser!.userId,
                      username: txtName.text,
                      userEmail: txtEmail.text,
                      userPassword: txtPassword.text,
                    );
                    await DBHelper.instance.updateUser(updated);
                    clearFields();
                    refresh();
                  },
                  child: Text("Update"),
                ),
              ],
            ),

            Divider(),

            // ================= LIST =================
            Expanded(
              child: FutureBuilder<List<User>>(
                future: DBHelper.instance.searchUser(),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<User> users = snapshot.data!;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {

                      User u = users[index];

                      return ListTile(
                        title: Text(u.username),
                        subtitle: Text(u.userEmail),

                        onTap: () {
                          setState(() {
                            selectedUser = u;
                            txtName.text = u.username;
                            txtEmail.text = u.userEmail;
                            txtPassword.text = u.userPassword;
                          });
                        },

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.instance.deleteUser(
                              u.userId!,
                            );
                            refresh();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}