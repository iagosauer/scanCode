import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TelaResposta extends StatelessWidget {
  TelaResposta({super.key, required this.context});
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return abreTela(context);
  }

  abreTela(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const shadow = BoxShadow(
      blurRadius: 10.0,
      color: Colors.black38,
      offset: Offset(0.0, 2.0),
      spreadRadius: 3,
    );
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      color: Colors.transparent,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox.expand(
                            child: TextButton(
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      textDirection: TextDirection.ltr,
                                      "SAIR",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: (20),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: Icon(Icons.exit_to_app_rounded),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
