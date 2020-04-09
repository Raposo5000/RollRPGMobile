import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        buttonColor: Colors.redAccent,
        accentColor: Colors.redAccent,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'D4';
  String dado = '';

  final textoProficiencia = TextEditingController();
  final textoDano = TextEditingController();

  var random = new Random();

  rand(int valor) {
    var txtProf;
    var txtDano;

    textoProficiencia.text.isEmpty == false
        ? txtProf = textoProficiencia.text
        : txtProf = '0';
    textoDano.text.isEmpty == false
        ? txtDano = textoProficiencia.text
        : txtDano = '0';

    setState(() {
      dado = (1 +
              random.nextInt(valor - 1) +
              int.tryParse(txtProf) +
              int.tryParse(txtDano))
          .toString();
    });
  }

  rolar(String dadoSelecionado) {
    if (dadoSelecionado == 'D4') rand(4);
    if (dadoSelecionado == 'D6') rand(6);
    if (dadoSelecionado == 'D8') rand(8);
    if (dadoSelecionado == 'D10') rand(10);
    if (dadoSelecionado == 'D12') rand(12);
    if (dadoSelecionado == 'D20') rand(20);
    if (dadoSelecionado == 'D100') rand(100);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('RollRPG'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text('Escolha o seu dado'),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            underline: Container(
              height: 1,
              color: Colors.redAccent,
            ),
            elevation: 16,
            items: <String>['D4', 'D6', 'D8', 'D10', 'D12', 'D20', 'D100']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: screen.width / 1.5,
            height: 45,
            child: new TextField(
              controller: textoProficiencia,
              decoration: InputDecoration(
                hintText: 'Bônus de Proficiência(Opcional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(12),
                WhitelistingTextInputFormatter.digitsOnly,
                BlacklistingTextInputFormatter.singleLineFormatter,
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: screen.width / 1.5,
            height: 45,
            child: new TextField(
              controller: textoDano,
              decoration: InputDecoration(
                hintText: 'Bônus Adicionais(Opcional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(12),
                WhitelistingTextInputFormatter.digitsOnly,
                BlacklistingTextInputFormatter.singleLineFormatter,
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text('Rolar'),
            onPressed: () {
              rolar(dropdownValue);
            },
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                Container(
                  width: screen.width / 2,
                  child: Image(
                    image: AssetImage('assets/images/d20.png'),
                  ),
                ),
                Text(
                  '$dado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
