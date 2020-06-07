import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/models/User/user.dart';
import 'package:task/services/TaskService.dart';
import 'package:task/services/UserService.dart';
import 'package:task/stores/user/user_store.dart';

class HomeState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomeState> {
  User _user;
  UserService _userService;
  TaskService _taskService;

  TaskService _taskReadOnly;

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
          body: _renderListTasks(),
          bottomNavigationBar: new TabBar(tabs: [
            Tab(
              icon: const Icon(Icons.calendar_today),
              text: 'In Progress',
            ),
            Tab(
              icon: const Icon(Icons.done_all),
              text: 'Done',
            ),
          ],
          labelColor: Color.fromRGBO(1, 43, 127, 1),
          unselectedLabelColor: Colors.blue[200],          
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.greenAccent[400],
          ),
          backgroundColor: Colors.white,
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
  _renderListTasks() {
      return Observer(builder: (ctx) {
        if (_taskService.taskStore.tasks.isEmpty) {
          return Center(child: Text("Sem tarefas para exibir"),);
        }
        return ListView(
          children: _taskService.taskStore.tasks.map((task){
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9),),
                child: new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(
                          width: 1.0, 
                          color: Colors.white24
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_today, 
                      color: Colors.white
                    ),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                                    
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[                      
                      Text(task.description, style: TextStyle(color: Colors.white)),                                            
                      Text("${DateFormat("dd/MM/yyyy HH:mm").format(task.deadLine)}", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
                ),
              ),
            );
          }).toList(),
        );
      });
  }
}



final makeCard = Card(
  elevation: 8.0,
  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  child: Container(
    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9),),
    child: makeListTile,
  ),
);

final makeBody = Container(
  child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9),),
          child: new ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12),
              decoration: new BoxDecoration(
                border: new Border(
                  right: new BorderSide(
                    width: 1.0, 
                    color: Colors.white24
                  ),
                ),
              ),
              child: Icon(
                Icons.autorenew, 
                color: Colors.white
              ),
            ),
            title: Text(
              "Introduction to Driving",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Icon(Icons.linear_scale, color: Colors.yellowAccent),
                Text(" Intermediate", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
          ),
        ),
      );
    },
  ),
);

final makeListTile = ListTile(
  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  leading: Container(
    padding: EdgeInsets.only(left: 12.0, right: 12),
    decoration: new BoxDecoration(
      border: new Border(
        right: new BorderSide(
          width: 1.0, 
          color: Colors.white24
        ),
      ),
    ),
    child: Icon(
      Icons.autorenew, 
      color: Colors.white
    ),
  ),
  title: Text(
    "Introduction to Driving",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

  subtitle: Row(
    children: <Widget>[
      Icon(Icons.linear_scale, color: Colors.yellowAccent),
      Text(" Intermediate", style: TextStyle(color: Colors.white))
    ],
  ),
  trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
);
