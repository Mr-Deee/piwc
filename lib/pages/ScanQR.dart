import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Users.dart';
import '../progressdialog.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
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
      if (firstname.isNotEmpty) {
        await firestore.collection('Attendance').add({
          'DateChecked': formattedDate ?? "",
          'Occupation': occupation ?? "",
          'HomeTown': hometown ?? "",
          'phone': phone ?? "",
          'username': '$firstname $lastname' ?? "",
          'email': email ?? "",
          'timestamp': FieldValue.serverTimestamp() ?? "",
        });

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
                    Navigator.of(context).pop();
                    setState(() {
                      isScanning = true;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }

    void onCapture(Result result) {
      setState(() {
        isScanning = false;
        resultData = result;
      });

      print('Scanned QR Code: $result');
    }

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
              typeCamera: TypeCamera.back, // Change to rear for web
              typeScan: TypeScan.live,
              onCapture: onCapture,
            ),
          ),
        ),
      );
    }

    Widget buildScannedData() {
      return Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     // 'Attendance Code: ${resultData?.code ?? ""}',
          //     // style: TextStyle(fontSize: 16),
          //   ),
          // ),
          Text("Name: $firstname $lastname"),
          Text("Email: $email"),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog(
                    message: "Checking your attendance, Please wait.....",
                  );
                },
              );

              try {
                DateTime now = DateTime.now();
                String formattedDate =
                    "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

                await addNewAttendance(formattedDate);
              } catch (error) {
                print('Error: $error');
              }
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
            buildQrCodeScanner(),
          if (!isScanning && resultData != null) buildScannedData(),
        ],
      ),
    );
  }
}
