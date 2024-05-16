import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scancode/scan/telaResposta.dart';

List<String> listaQRs = ['1234', '5678', '102030', '852963'];
Barcode? result;

_abreTelaMensagem(BuildContext context) {
  if (result != null) {
    if (listaQRs.contains(result?.code ?? '')) {
      TelaResposta(context: context).build(context);
    }
  }
  result = null;
}

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  QRViewController? controller;
  bool DialogControler = true;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          if (result != null) _abreTelaMensagem(context) else const Text('')
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (DialogControler) {
        if (listaQRs.contains(scanData.code)) {
          _showDialog(scanData.code ?? '', true);
        } else {
          _showDialog(scanData.code ?? '', false);
        }
        setState(() {
          DialogControler = false;
        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _showDialog(String data, bool valido) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('QR Code Scanned'),
          content: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: valido ? Text("VALIDO") : Text("Não Válido"),
                  height: 200,
                  width: 200,
                  color: valido ? Colors.green : Colors.red,
                  alignment: Alignment.topLeft,
                ),
              ),
              Text('Data: $data'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  DialogControler = true;
                });
              },
              child: Text('Voltar'),
            ),
          ],
        );
      },
    );
  }
}
