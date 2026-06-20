import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.instance.database;
  runApp(BookStore());
}
class BookStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookPage(),
    );
  }
}
class Book {
  int bookTitle;
  String bookName;
  String bookauthor;
  int quantity;
  int bookStock;

  Book({
    required this.bookTitle,
    required this.bookName,
    required this.bookauthor,
    required this.quantity,
    required this.bookStock,
  });
  Map<String ,dynamic> toMap(){
    return {
      'bookTitle': bookTitle,
      'bookName': bookName,
      'bookauthor': bookauthor,
      'quantity': quantity,
      'bookStock': bookStock,
    };
  }
    factory Book.fromMap(Map <String, dynamic> map) {
      return Book(
        bookTitle: map['bookTitle'],
        bookName: map['bookName'],
        bookauthor: map['bookauthor'],
        quantity: map['quantity'],
          bookStock: map['bookStock']
      );
    }

  }
class DBhelper {
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _db;

  Future<Database> get database async =>
      _db ??= await _initDB();

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "book.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE book(
  bookTitle TEXT ,
  bookName TEXT,
  bookauthor TEXT,
  quantity INTEGER,
  bookStock Text,
  )
  ''');
  }

  Future<int> addBook(Book b) async {
    Database db = await instance.database;
    return await db.add('book', b.toMap());
  }

  Future<List<Book>> searchBook() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> bookList =
    await db.query("book");

    return List.generate(
      bookList.length,
          (i) => Book.fromMap(bookList[i]),
    );
  }

  Future<int> updateBook(Book b) async {
    Database db = await instance.database;

    return await db.update(
      "book",
      b.toMap(),
      where: 'bookTitle = ?',
      whereArgs: [b.bookTitle],
    );
  }

  Future<int> deleteBook(int id) async {
    Database db = await instance.database;

    return await db.delete(
      "book",
      where: 'bookTitle = ?',
      whereArgs: [bookTitle],
    );
  }
}
class BookPage extends StatefulWidget {
  @override
  State<BookPage> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  TextEditingController BookName =
  TextEditingController();

  TextEditingController bookauthor =
  TextEditingController();

  TextEditingController bookTitle =
  TextEditingController();
  TextEditingController Quantity =
  TextEditingController();
  TextEditingController bookStock =
  TextEditingController();

  Book? selectedBook;

  void clearFields() {
    BookName.clear();
    bookauthor.clear();
    bookTitle.clear();
    Quantity.clear();
    bookStock.clear();
    selectedBook = null;
  }

  void refresh() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Store CRUD"),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [

              TextField(
              controller: BookName,
            ),

            TextField(
              controller: bookauthor,
            ),

            TextField(
              controller: bookTitle,
            ),
            SizedBox(height: 20),

                Row(
                  children: [

                    ElevatedButton(
                      onPressed: () async {
                        Book b = Book(
                          BookName: BookName.text,
                          bookauthor: bookauthor.text,
                          bookTitle:
                          Quantity:int.parse(Quantity.text),
                            bookStock:int.parse(bookStock
                            .text),
                        );

                        await DBHelper.instance
                            .insertBook(b);

                        clearFields();
                        refresh();
                      },
                      child: Text("Add"),
                    ),

                    SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: selectedBook == null
                          ? null
                          : () async {

                        Book b = Book(
                          bookId:
                          selectedBook!.bookId,
                          bookName:
                          txtBookName.text,
                          authorName:
                          txtAuthorName.text,
                          quantity: int.parse(
                              txtQuantity.text),
                        );

                        await DBHelper.instance
                            .updateBook(b);

                        clearFields();
                        refresh();
                      },
                      child: Text("Update"),
                    ),
                  ],
                ),

                Divider(),

                Expanded(
                  child: FutureBuilder<List<Book>>(
                    future:
                    DBHelper.instance.searchBook(),
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }

                      List<Book> books =
                      snapshot.data!;

                      return ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {

                          Book b = books[index];

                          return ListTile(
                            title: Text(b.bookName),
                            subtitle: Text(
                              "Author: ${b.authorName}\n"
                                  "Quantity: ${b.quantity}",
                            ),

                            onTap: () {
                              setState(() {
                                selectedBook = b;

                                txtBookName.text =
                                    b.bookName;

                                txtAuthorName.text =
                                    b.authorName;

                                txtQuantity.text =
                                    b.quantity.toString();
                              });
                            },

                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {

                                await DBHelper.instance
                                    .deleteBook(
                                    b.bookId!);

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