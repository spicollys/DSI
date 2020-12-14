import 'package:dsi_app/infra.dart';
import 'package:flutter/material.dart';
import 'package:dsi_app/constants.dart';


class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      body: Column(
        children: [
          Spacer(),
          Image(
            image: Images.bsiLogo,
            height: 100,
          ),
          Constants.spaceSmallHeight,
          ForgotPasswordForm(),
          Spacer(),
        ],
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPasswordForm>{
  final _formKey = GlobalKey<FormState>();

  void _cancel(){
    Navigator.of(context).pop();
  }

  void _sentEmail(){
    if (!_formKey.currentState.validate())return;

    dsiDialog.showInfo(
      context: context,
      message: 'Um e-mail para alteração de senha foi enviado.',
      buttonPressed: () => Navigator.of(context)..pop()..pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: Constants.paddingMedium,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail*'),
                validator: (String value) {
                  return value.isEmpty ? 'Email inválido.' : null;
                },
              ),
              Constants.spaceSmallHeight,
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Enviar e-mail para alteração de senha'),
                  onPressed: _sentEmail,
                ),
              ),
              FlatButton(
                child: Text('Cancelar'),
                padding: Constants.paddingSmall,
                onPressed: _cancel,
              ),
            ],
          ),
        )
    );
  }
}