import 'package:flutter/material.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  String textURL = "";
  String textMem = "";
  late TextEditingController controllerURL;
  late TextEditingController controllerMem;

  @override
  void initState() {
    super.initState();
    controllerURL = TextEditingController();
    controllerMem = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ColoredBox(
          color: Colors.black,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: InkWell(
                      child: DecoratedBox(
                        decoration: decoration,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            textURL.isEmpty
                                ? "https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg"
                                : textURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () async {
                        showInput();
                      },
                    ),
                  ),
                  InkWell(
                    child: DecoratedBox(
                      decoration: decoration,
                      child: Text(
                        textMem.isEmpty ? "Здесь мог бы быть ваш мем" : textMem,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      showInput();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showInput() async {
    controllerURL.text = textURL;
    controllerMem.text = textMem;

    var result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Column(
              children: [
                TextField(
                  controller: controllerURL,
                ),
                TextField(
                  controller: controllerMem,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop({
                          'URL': controllerURL.text,
                          'Mem': controllerMem.text
                        });
                      },
                      child: Text("ОК"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Отмена"),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(
        () {
          textURL = result['URL'].isEmpty
              ? ""
              : result['URL'];

          textMem = result['Mem'].isEmpty
              ? ""
              : result['Mem'];
        },
      );
    }
  }
}
