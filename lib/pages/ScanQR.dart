import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
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
                  await firestore.collection('qr_codes').add({
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
            Text(
              'Scanned QR Code: ${result!.code}',
              style: TextStyle(fontSize: 16),
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
