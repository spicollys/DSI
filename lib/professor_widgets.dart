import 'package:dsi_app/pessoa.dart';
import 'package:dsi_app/professor.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'dsi_widgets.dart';
import 'infra.dart';

class ListProfessorPage extends StatefulWidget {
  @override
  DsiListPageState<Professor, ListProfessorPage> createState() =>
      DsiListPageState<Professor, ListProfessorPage>(
        title: 'Lista de Professores',
        listDataBuilder: () => professorController.getAll(),
        remover: (context, object) => professorController.remove(object),
        builder: (context, object) {
          return DsiFutureBuilder(
            key: UniqueKey(),
            target: object,
            builder: (context, professor) => ListTile(
              title: Text(professor.pessoa.nome),
              subtitle: Text('dpt. ${professor.departamento} num. sala ${professor.numeroSala}'),
              onTap: () =>
                  dsiHelper.go(context, "/maintain_professor", arguments: professor),
            ),
          );
        },
        floatingActionButtonBuilder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => dsiHelper.go(context, '/maintain_professor'),
        ),
      );
}


class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    //o objeto passado como argumento pelo dsiHelper.go é recuperado aqui
    if (professor==null){
      professor = Professor();
      professor.pessoa = Pessoa();
    }
    return DsiBasicFormPage(
      title: 'Professor',
      onSave: (){
        professorController.save(professor).then((value) {
          dsiHelper.go(context, '/list_professor');}
        );
      },
      body: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: Constants.boxSmallHeight.height,
        children: <Widget>[

          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Departamento*'),
            validator: (String value) => value.isEmpty ? 'Departamento inválido.' : null,
            initialValue: professor.departamento,
            onSaved: (String newValue) => professor.departamento = newValue,
          ),
          Constants.boxSmallHeight,
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Número da sala*'),
            validator: (String value) => value.isEmpty ? 'Número de sala inválido.' : null,
            initialValue: professor.numeroSala,
            onSaved: (newValue) => professor.numeroSala = newValue,
          ),
        ],
      ),
    );
  }
}
