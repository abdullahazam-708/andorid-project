import "package:flutter/material.dart";
import "package: firebase_core/firebase_core.dart";
import "package: cloud_firebase/cloud_firebase.dart";

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      option: Firebase Options(
  apiKey:"AIzaSyCZR0mFTthDC8iKuwjRJJ4N2FWkfGlwYD8"  // client --> API key
  authDomain: ""
      projectId: "flutter-01-af627" // project_info --> project_id
      storageBucket: "flutter-01-af627.firebasestorage.app" // project_info --> storage_bucket
  MessagingSenderId: "552683202583" // project_info --> project_number
  appId:"552683202583" // client --> clilent_info --> mobilesdk_app_id
  ),
  );

  runApp(FirebaseApp());
  }

class FirebaseApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: SmartPhoneHome(),
    );
  }
}

class SmartPhoneHome extends StatelessWidget{
  @override
  PhoneState createState() => PhoneState();
}

class PhoneState extends State<SmartPhoneHome>{
  TextEditingController txtBrand = TextEditingController();
  TextEditingController txtModel = TextEditingController();
  TextEditingController txtIMEI = TextEditingController();
  TextEditingController txtPrice = TextEditingController();

  String? editDocId;
}

Future<void> saveRecord() async{
  if(editDocId == null){
    await FirebaseFirestore.instance.collection("smartphones").add({
      "brand": txtBrand.text,
      "model": txtModel.text,
      "imei": txtIMEI.text,
      "price": txtPrice.text,
      "timestamp": Timestamp.now(),
    });
  }else{
    await FirebaseFirestore.instance.collection("smartphones").doc(editDocId).update({
      "brand": txtBrand.text,
      "model": txtModel.text,
      "imei": txtIMEI.text,
      "price": txtPrice.text,
      "timestamp": Timestamp.now(),
    });
    editDocId = null;
  }
  clearFields();
}

Future<void> deleteRecord(String docId) async{
  await FirebaseFirestore.instance.collection("smartphones").doc(docId).delete();
}

void clearFields(){
  txtBrand.clear();
  txtModel.clear();
  txtIMEI.clear();
  txtPrice.clear();
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Smart Phone Database"),),
    body: Padding(padding: EdgeInsets.all(14.5),
      child: Column(
        children: [
          TextField(
            controller: txtBrand,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Brand",
            ),
          ),
          ElevatedButton(onPressed: () async{
            await saveRecord();
          },
            child: Text(editDocId == null ? "Save" : "Update"),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("smartphones").orderBy(
                  "timestamp", descending: true).snapshots(),
            ),

          ),

          SizedBox(height: 14.5),
          TextField(
            controller: txtModel,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Model",
            ),
          ),
        ],
      ),
    ),
  );
}







// Collection = DB Table
// document = record
use icon but