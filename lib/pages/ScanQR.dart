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
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    var firstname = Provider.of<Users>(context).userInfo?.fname ?? "";
    var email = Provider.of<Users>(context).userInfo?.email ?? "";

    Future<void> addNewAttendance(String formattedDate) async {
      if (result != null) {
        // Write the scanned QR code data to Firebase
        await firestore.collection('Attendance').add({
          'DateChecked': formattedDate,
          'username': firstname,
          'email': email,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a pop-up (dialog) with a "Thanks" message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thanks'),
              content: Text('Attendance recorded. Thanks!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      isScanning = true; // Resume scanning
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Scanner'),
      ),
      body: Column(
        children: <Widget>[
          if (isScanning)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (QRViewController controller) {
                      controller.scannedDataStream.listen((barcode) async {
                        setState(() {
                          result = barcode;
                          isScanning = false; // Stop scanning after QR code is captured
                        });

                        // Perform any other actions you need with the scanned data
                        print('Scanned QR Code: ${barcode.code}');
                      });
                    },
                  ),
                ),
              ),
            ),
          if (!isScanning && result != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Attendance Code: ${result!.code}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text("Name: $firstname"),
                Text("Email: $email"),
                ElevatedButton(
                  onPressed: () {
                    // Finish the attendance process
                    DateTime now = DateTime.now();

                    // Format the date as a string (e.g., "2023-09-21")
                    String formattedDate =
                        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

                    addNewAttendance(formattedDate);
                  },
                  child: Text('Click Done to Finish Attendance'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
