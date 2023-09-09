import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Users.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();


    // Format the date as a string (e.g., "2023-09-21")
    String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    var firstname = Provider.of<Users>(context).userInfo?.fname!;
    var lastname = Provider.of<Users>(context).userInfo?.lname!;
    var email = Provider.of<Users>(context).userInfo?.email!;
    var Occupation = Provider.of<Users>(context).userInfo?.Occupasion!;

    addnewattendance()async{

      // Write the scanned QR code data to Firebase
      await firestore.collection('Attendance').doc(result as String?).update({
        'DateChecked':formattedDate,
        'username':firstname,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                controller.scannedDataStream.listen((barcode) async {
                  setState(() {
                    result = barcode;
                  });

                  // Write the scanned QR code data to Firebase
                  await firestore.collection('Attendance').add({
                    'date':formattedDate,
                    'data': barcode.code,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  // Perform any other actions you need with the scanned data
                  print('Scanned QR Code: ${barcode.code}');
                });
              },
            ),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Attendance Code: ${result!.code}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          Container(
            child: Row(
              children: [
                Text("Name:"),
                Text(firstname ?? "loading"),
              ],
            ),
          ),
          Row(
            children: [
              Column(children: [
                Text(email ?? "loading"),
              ]),


            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your floating button action here
          addnewattendance();
        },
        child: Icon(Icons.add_task), // You can replace 'Icons.add' with your desired image
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
