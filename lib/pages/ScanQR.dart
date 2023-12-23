import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../model/Users.dart';
import '../progressdialog.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Result? result;
  Result? resultData;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    var firstname = Provider.of<Users>(context).userInfo?.fname ?? "";
    var lastname = Provider.of<Users>(context).userInfo?.lname ?? "";
    var email = Provider.of<Users>(context).userInfo?.email ?? "";
    var phone = Provider.of<Users>(context).userInfo?.phone ?? "";
    var occupation = Provider.of<Users>(context).userInfo?.Occupation ?? "";
    var hometown = Provider.of<Users>(context).userInfo?.hometown ?? "";


    Future<void> addNewAttendance(String formattedDate) async {
      if (result != null) {
        // Write the scanned QR code data to Firebase
        await firestore.collection('Attendance').add({
          'DateChecked': formattedDate,
          'Occupation': occupation,
          'HomeTown': hometown,
          'phone': phone,
          'username': '$firstname $lastname',
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

    // Function to handle QR code capture
    void onCapture(Result result) {
      setState(() {
        isScanning = false; // Stop scanning after QR code is captured
        resultData = result;
      });

      // Perform any other actions you need with the scanned data
      print('Scanned QR Code: $result');
    }

    // Widget for displaying the QR code scanner
    Widget buildQrCodeScanner() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: QRCodeDartScanView(
              key: qrKey,
              typeCamera: TypeCamera.back,
              typeScan: TypeScan.live,
              onCapture: onCapture,
            ),
          ),
        ),
      );
    }

    // Widget for displaying information after scanning
    Widget buildScannedData() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Attendance Code: ${resultData ?? ""}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text("Name: $firstname $lastname"),
          Text("Email: $email"),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog(
                    message: "Checking your attendance, Please wait.....",
                  );
                },
              );
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Scanner'),
      ),
      body: Column(
        children: <Widget>[
          if (isScanning)
            buildQrCodeScanner(), // Show QR code scanner if scanning
          if (!isScanning && resultData != null)
            buildScannedData(), // Show scanned data if not scanning
        ],
      ),
    );
  }
  //   Future<void> addNewAttendance(String formattedDate) async {
  //     if (result != null) {
  //       // Write the scanned QR code data to Firebase
  //       await firestore.collection('Attendance').add({
  //         'DateChecked': formattedDate,
  //         'Occupation': occupation,
  //         'HomeTown': hometown,
  //         'phone': phone,
  //         'username': firstname + lastname,
  //         'email': email,
  //         'timestamp': FieldValue.serverTimestamp(),
  //       });
  //
  //       // Show a pop-up (dialog) with a "Thanks" message
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Thanks'),
  //             content: Text('Attendance recorded. Thanks!'),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close the dialog
  //                   setState(() {
  //                     isScanning = true; // Resume scanning
  //                   });
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Attendance Scanner'),
  //     ),
  //     body: Column(
  //       children: <Widget>[
  //         if (isScanning)
  //           Container(
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.blue, width: 2.0),
  //               borderRadius: BorderRadius.circular(12.0),
  //             ),
  //             margin: EdgeInsets.all(16.0),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10.0),
  //               child: AspectRatio(
  //                   aspectRatio: 1.0,
  //                   child: QRCodeDartScanView(
  //                       key: qrKey,
  //                       typeScan: TypeScan.live,
  //                       onCapture: (Result result) {
  //                         // onQRViewCreated: (QRViewController controller) {
  //                         //   controller.scannedDataStream.listen((barcode) async {
  //                         setState(() {
  //                           // result = barcode;
  //                           isScanning = false; // Stop scanning after QR code is captured
  //                         });
  //
  //                         // Perform any other actions you need with the scanned data
  //                         print('Scanned QR Code: ${result}');
  //                       }
  //                   )
  //
  //               ),
  //
  //             ),
  //           ),
  //         if (!isScanning && result != null)
  //           Column(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   'Attendance Code: ${result!.code}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //               ),
  //               Text("Name: $firstname"),
  //               Text("Email: $email"),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   showDialog(
  //                       context: context,
  //                       barrierDismissible: false,
  //                       builder: (BuildContext context) {
  //                         return ProgressDialog(
  //                           message: "Checking your attendance ,Please wait.....",
  //                         );
  //                       });
  //                   // Finish the attendance process
  //                   DateTime now = DateTime.now();
  //
  //                   // Format the date as a string (e.g., "2023-09-21")
  //                   String formattedDate =
  //                       "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  //
  //                   addNewAttendance(formattedDate);
  //                 },
  //                 child: Text('Click Done to Finish Attendance'),
  //               ),
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
