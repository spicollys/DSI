import 'dart:math';
import 'package:dsi_app/constants.dart';
import 'package:dsi_app/infra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  int _bodyIndex = 0;

  void _changeBodyIndex(){
    switch (_bodyIndex){
      case 0:
        setState(() {
          _bodyIndex = 1;
        });
        break;
      case 1:
        setState(() {
          _bodyIndex = 0;
        });
        break;
    }
  }

  AppBar _buildAppBar(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => dsiHelper..back(context)..go(context, HomePage()),
      ),
      title: Text('Home'),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: _changeBodyIndex,
          ),
        ),
        Icon(Icons.more_vert),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return DsiScaffold(
      appBar: _buildAppBar(),

      body: _bodyIndex == 0 ? LogoLayout() : FormLayout(),
    );
  }
}

class LogoLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff7ffe8), Color(0xffc2ca94)],
            // Color(0xffc7ffba)
            stops: [0.8, 1.0],
            transform: GradientRotation(pi / 2.03),
          ),
          image: DecorationImage(
            image: Images.bsiLogo,
          ),
        ),
      ),
    );
  }
}

class FormLayout extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    void _saveForm(){
      if (!_formKey.currentState.validate()) return;
      dsiDialog.showInfo(
        context: context,
        message: 'Formulário salvo.',
        buttonPressed: () => dsiHelper..back(context)..go(context, HomePage()),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: Constants.paddingMedium,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo deve ser preenchido.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(labelText: 'Nascimento'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo deve ser preenchido.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Gênero'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo deve ser preenchido.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Período'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo deve ser preenchido.' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Matrícula'),
              validator: (String value) {
                return value.isEmpty ? 'Este campo deve ser preenchido.' : null;
              },
            ),
            Constants.spaceMediumHeight,
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Salvar'),
                onPressed: _saveForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}