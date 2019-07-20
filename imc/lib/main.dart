import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formeKey = GlobalKey<FormState>();
  String _info = "Informe seus dados";

//Função para resetar os campos
  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _info = "Informe seus dados";
      _formeKey = GlobalKey<FormState>();
    });
  }

//Função para Informar o resultado do IMC
  void _changeInfo() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double _imc = weight / (height * height);

      if (_imc < 18.5) {
        _info = "Abaixo do peso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 18.5 && _imc <= 24.9) {
        _info = "Peso Normal (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 25 && _imc <= 29.9) {
        _info = "Sobrepeso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 30 && _imc <= 34.9) {
        _info = "Obesidade grau 1 (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 35 && _imc <= 39.9) {
        _info = "Obesidade grau 2 (${_imc.toStringAsPrecision(3)})";
      } else {
        _info = "Obesidade grau 3  (${_imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text(
            "IMC",
            style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black54,
                  size: 30,
                ),
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  _resetFields();
                })
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 0.0),
        child: Form(
          key: _formeKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.polymer, size: 120.0, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.black54)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 20.0),
                controller: weightController,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira o Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.black54)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 20.0),
                controller: heightController,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira a Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      if (_formeKey.currentState.validate()) {
                        _changeInfo();
                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
