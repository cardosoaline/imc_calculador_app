import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  @override
  _CalculadoraImcState createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText ="informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      String _infoText = "informe seus dados!";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoText = "Peso normal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc <= 29.9) {
        _infoText = "Sobrepeso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc <= 34.9) {
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "besidade grau 2 (${imc.toStringAsPrecision(3)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetFields,
        )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline,
                  size: 120.0,
                  color: Colors.purpleAccent),
              TextFormField(keyboardType: TextInputType.number,decoration: InputDecoration(
                  labelText: "Peso(Kg)",
                  labelStyle: TextStyle(color: Colors.green),
              ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purpleAccent,fontSize: 25.0),
                controller: weightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura(Cm)",
                  labelStyle: TextStyle(color: Colors.green)
              ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purpleAccent,fontSize: 25.0),
                controller: heightController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child:  Container(
                  height: 80.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                    style: TextStyle(color: Colors.white,fontSize: 25.0),
                  ),
                    color: Colors.purpleAccent,
                  ),
                ),
              ),

              Text(_infoText,
                textAlign: TextAlign.center,
                style:
                TextStyle(color: Colors.purpleAccent,fontSize: 25.0))
            ],
          ) ,
        ),
      ),
    );
  }
}
