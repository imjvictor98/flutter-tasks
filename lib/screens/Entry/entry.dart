import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/Home/home.dart';
import 'package:task/services/UserService.dart';
import 'package:task/stores/user/user_store.dart';



class Entry extends StatefulWidget {

  @override
  _Entry createState() => _Entry();
}


class _Entry extends State<Entry> {
  String _name = "";
  UserService _userService;

  @override
  void initState() {
    super.initState();
  }

  _login() {
    try {
      _userService.login(_name).then((user){
        if (user == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("User not registered!"),
          ));          
        }      
      }).catchError((onError){
        throw "Error on login!";
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 30, bottom: 0, right: 30),
              child: Row(
                children: <Widget>[              
                  Text("Nome", 
                    style:  TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'                    
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 0.0, 
                left: 30,
                right: 30,
                top: 0.0),
              child: TextField(
                onChanged: (name) {
                  this._name = name;
                },            
                style: TextStyle(
                  color: Color.fromRGBO(0, 156, 118, 1),
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500
                ),
                decoration: InputDecoration(                            
                  border: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Color.fromRGBO(246, 246, 246, 0),
                      width: 1
                    )
                  ),
                  labelStyle: new TextStyle(
                    color: Colors.green
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1)
                  ),                                 
                ),
                
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),         
            Padding( 
              padding: const EdgeInsets.only(left: 30, bottom: 0, top: 15, right: 30),
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
                        "Entrar",
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
                  _login();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeState()));
                },
                shape: const StadiumBorder(),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
