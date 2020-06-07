import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/services/UserService.dart';
import 'package:task/utils/date_time_form.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  UserService _userService;
  //Implement the taskServie

  String _title;
  String _description;
  DateTime _deadLine;
  bool _done = false;

  FocusNode _focusTitle;
  FocusNode _focusDescription;
  FocusNode _focusDeadLine;

  @override
  void initState() {
    super.initState();
    this._focusTitle = FocusNode();
    this._focusDescription = FocusNode();
    this._focusDeadLine = FocusNode();
  }

  @override
  void dispose() {
    this._focusTitle.dispose();
    this._focusDescription.dispose();
    this._focusDeadLine.dispose();
    super.dispose();
  }

  _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }


  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    //Implement task definiton  

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bom Dia, ${_userService.userStore.user.name}", 
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter'),
          ),
          backgroundColor: Color.fromRGBO(0, 156, 118, 1),
          elevation: 5,
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                /* TF for Title */
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    focusNode: this._focusTitle,
                    validator: (title) {
                      if (title.isEmpty) {
                        return "Título";
                      }
                      return null;
                    },
                    onFieldSubmitted: (title) {
                      this._focusTitle.unfocus();
                      this._focusDescription.requestFocus();
                    },
                    onSaved: (title) {
                      this._title = title;
                    },
                    decoration: InputDecoration(hintText: "Título da tarefa", labelText: "Título", icon: Icon(Icons.title)),
                  ),
                ),
                /* TF for Description */
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    focusNode: this._focusDescription,
                    validator: (description) {
                      if (description.isEmpty) {
                        return "Descrição";
                      }
                      return null;
                    },
                    onFieldSubmitted: (description) {
                      this._focusDescription.unfocus();
                      this._focusDeadLine.requestFocus();
                    },
                    onSaved: (description) {
                      this._description = description;
                    },
                    decoration: InputDecoration(hintText: "Descrição da tarefa", labelText: "Descrição", icon: Icon(Icons.description)),
                  ),
                ),
                /* TF for DeadLine */
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: DateTimeFormField(
                    inputType: Type.both,
                    format: DateFormat("dd/MM/yyyy HH:mm"),
                    textInputAction: TextInputAction.next,
                    focusNode: _focusDeadLine,
                    validator: (deadLine) {
                      if (deadLine == null) {
                        return "Prazo final";
                      }
                      return null;
                    },
                    onFieldSubmitted: (deadLine) {
                      this._focusDeadLine.unfocus();                      
                    },
                    onSaved: (deadLine) {
                      this._deadLine = deadLine;
                    },
                    inputDecoration: InputDecoration(hintText: "Prazo final", labelText: "Prazo"),
                  ),
                ),                                
              ],
            ),
          ),        
          /* B for Saving */
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
            child: RawMaterialButton(                
                  fillColor: Color.fromRGBO(1, 43, 127, 1),
                  splashColor: Color.fromRGBO(55, 89, 187, 1),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Criar tarefa",
                          maxLines: 1,                      
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,                        
                            ),                          
                        ),
                      ],
                    ),
                  ),                
                  onPressed: () {              
                  },
                  shape: const StadiumBorder(),                
                ),
          )          
        ],
      ),
    );
  }

}