import 'package:dsi_app/constants.dart';
import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/infra.dart';
import 'package:dsi_app/pessoa.dart';
import 'package:flutter/material.dart';

class Professor extends Pessoa {
  String departamento;
  String numeroSala;
  Professor({cpf, nome, endereco, this.departamento, this.numeroSala})
      : super(cpf: cpf, nome: nome, endereco: endereco);
}

var professorController = ProfessorController();

class ProfessorController {
  List<Professor> getAll(){
    return pessoaController.getAll().whereType<Professor>().toList();
  }

  Professor save(professor){
    return pessoaController.save(professor);
  }

  bool remove(professor) {
    return pessoaController.remove(professor);
  }
}

class ListProfessorPage extends StatefulWidget {
  @override
  ListProfessorPageState createState() => ListProfessorPageState();
}

class ListProfessorPageState extends State<ListProfessorPage> {
  List<Professor> _professor = professorController.getAll();
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      title: 'Listagem de Professores',
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => dsiHelper.go(context, '/maintain_professor'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _professor.length,
          itemBuilder: _buildListTileProfessor),
    );
  }

  Widget _buildListTileProfessor(context, index){
    var professor = _professor[index];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        setState(() {
          professorController.remove(professor); //UseCase removing
          _professor.remove(index); //UI removing
        });
        dsiHelper.showMessage(
          context: context,
          message: '${professor.nome} foi removido.',
        );
      },
      background: DsiListTileBackground(),
      child: ListTile(
        title: Text(professor.nome),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dpt. ${professor.departamento}'),
            SizedBox(width: 8.0),
            Text('Sala. ${professor.numeroSala}'),
          ],
        ),
        onTap: () => dsiHelper.go(context, '/maintain_professor', arguments: professor),
      ),
    );
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    //o objeto passado como argumento pelo dsiHelper.go é recuperado aqui
    if (professor==null){
      professor = Professor();
    }
    return DsiBasicFormPage(
      title: 'Professor',
      onSave: (){
        professorController.save(professor);
        dsiHelper.go(context, '/list_professor');
      },
      body: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: Constants.spaceSmallHeight.height,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'CPF*'),
            validator: (String value) => value.isEmpty ? 'CPF inválido.' : null,
            initialValue: professor.cpf,
            onSaved: (String newValue) => professor.cpf = newValue,
          ),
          Constants.spaceSmallHeight,
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Nome*'),
            validator: (String value) => value.isEmpty ? 'Nome inválido.' : null,
            initialValue: professor.nome,
            onSaved: (String newValue) => professor.nome = newValue,
          ),
          Constants.spaceSmallHeight,
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Endereço*'),
            validator: (String value) => value.isEmpty ? 'Endereço inválido.' : null,
            initialValue: professor.endereco,
            onSaved: (String newValue) => professor.endereco = newValue,
          ),
          Constants.spaceSmallHeight,
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Departamento*'),
            validator: (String value) => value.isEmpty ? 'Departamento inválido.' : null,
            initialValue: professor.departamento,
            onSaved: (String newValue) => professor.departamento = newValue,
          ),
          Constants.spaceSmallHeight,
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
