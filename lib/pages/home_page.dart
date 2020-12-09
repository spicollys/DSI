
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial',
        )
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text('Próxima página'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 16.0)
            ),
            color: Colors.green,
            focusColor: Colors.greenAccent,
            onPressed: () => Navigator.pushNamed(context, '/dsi_page'),
          ),
        ),
      ),
    );
  }
}
