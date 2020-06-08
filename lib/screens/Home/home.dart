import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:task/models/Task/task.dart';
import 'package:task/models/User/user.dart';
import 'package:task/services/TaskService.dart';
import 'package:task/services/UserService.dart';
import 'package:task/stores/user/user_store.dart';

class HomeState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomeState> {
  UserService _userService;
  TaskService _taskService;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    _taskService = Provider.of<TaskService>(context);
    
    return new MaterialApp(      
      color: Colors.yellow,      
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(          
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
          body: TabBarView(children: [          
            // Container(
            //   child: _renderListTasksUndone(),
            //   color: Colors.grey[100],
            // ),
            new Column(          
              crossAxisAlignment: CrossAxisAlignment.start,                  
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),                  
                ),
                new Expanded(child: _renderListTasksUndone()),
              ],
            ),
            _renderListTasksDone()
          ]),
          bottomNavigationBar: new TabBar(tabs: [
            Tab(
              icon: const Icon(Icons.calendar_today),
              text: 'Pendentes',
            ),
            Tab(
              icon: const Icon(Icons.done_all),
              text: 'Concluídas',
            ),
          ],
          labelColor: Color.fromRGBO(1, 43, 127, 1),
          unselectedLabelColor: Colors.blue[200],          
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.greenAccent[400],
          ),
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          floatingActionButton: Observer(
            builder: (ctx) {
              if (_userService.userStore.user.name.length > 0) {
                return FloatingActionButton(
                  backgroundColor: Color.fromRGBO(1, 43, 127, 1),
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed("new_task");
                  },
                );
              } else {
                return SizedBox.shrink();
              }              
            }
          ),
        ),        
      ),            
    );  
  }
  _renderListTasksUndone() {
      return Observer(builder: (ctx) {
        if (_taskService.taskStore.tasks.isEmpty) {
          return Center(child: Text("Sem tarefas em andamento para exibir"));
        }
        
        var listFiltered = _taskService.taskStore.tasks.where((element) => !element.done).toList();
        
        if (listFiltered == null || listFiltered.isEmpty) {
          return Center(child: Text("Sem tarefas em andamento para exibir"),);
        }        
        return ListView(                             
          children: listFiltered.map((task) {                                                                   
            return Card(                                 
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              shape: StadiumBorder(
                side: BorderSide(                  
                  style: BorderStyle.none,                  
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.only(
                    topLeft:  const  Radius.circular(25.0),
                    topRight: const  Radius.circular(25.0),
                    bottomLeft: const  Radius.circular(25.0),
                    bottomRight: const  Radius.circular(25.0),
                  ),
                ),
                child: new ListTile(  
                  onTap: () {                     
                     setState(() {
                      _taskService.setDone(task.id);  
                     });
                  },                                  
                  enabled: true,                  
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12),
                    
                    child: Icon(
                      Icons.calendar_today, 
                      color: Color.fromRGBO(1, 43, 127, 1),

                    ),                    
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1), 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'
                    ),
                  ),
                                    
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[                      
                      Text(
                        task.description, 
                        style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontFamily: 'Inter'
                          ),
                        ),  
                      Text(
                        "${DateFormat("dd/MM/yyyy HH:mm").format(task.deadLine)}",                         
                        style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                    ],
                  ),
                  trailing:
                    Text(
                      "Pendente", 
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                      ),
                    ),                  
                ),
              ),
            );              
          }).toList(),        
        );
      });
  }

  _renderListTasksDone() {
    return Observer(builder: (ctx) {
        if (_taskService.taskStore.tasks.isEmpty) {
          return Center(child: Text("Sem tarefas para exibir"));
        }
        
        var listFiltered = _taskService.taskStore.tasks.where((element) => element.done).toList();
        
        if (listFiltered == null || listFiltered.isEmpty) {
          return Center(child: Text("Sem tarefas feitas para exibir"),);
        }        
        return ListView(                             
          children: listFiltered.map((task) {                                                                   
            return Card(                                 
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              shape: StadiumBorder(
                side: BorderSide(                  
                  style: BorderStyle.none,                  
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:  const  Radius.circular(25.0),
                    topRight: const  Radius.circular(25.0),
                    bottomLeft: const  Radius.circular(25.0),
                    bottomRight: const  Radius.circular(25.0),
                  ),
                ),
                child: new ListTile(                                  
                  enabled: true,                  
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12),
                    
                    child: Icon(
                      Icons.calendar_today, 
                      color: Color.fromRGBO(1, 43, 127, 1),

                    ),                    
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1), 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'
                    ),
                  ),
                                    
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[                      
                      Text(
                        task.description, 
                        style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontFamily: 'Inter'
                          ),
                        ),  
                      Text(
                        "Prazo encerrado",                         
                        style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                    ],
                  ),
                  trailing:
                    Text(
                      "Concluida", 
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color.fromRGBO(0, 156, 118, 1),
                        fontWeight: FontWeight.bold
                      ),
                    ),                    
                ),
              ),
            );              
          }).toList(),        
        );
      });
  }
}
