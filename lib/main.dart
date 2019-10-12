import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
Map _data;
List _features ;

void main() async {

 _data = await getQuakes();
_features=_data['features']; 
runApp(MyApp());

}
 

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quakes',
      theme: ThemeData(
      primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Our Quakes App'),
    );
  } 
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        child:  new ListView.builder(
              itemCount: _features.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (BuildContext context,int position){
                if(position.isOdd) return new Divider();
                final index = position ~/ 2;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text("${_features[index]['properties']['mag']}",
                    style: TextStyle(fontSize: 16.5,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),),
                  ),
                  title: Text("${_features[index]['properties']['mag']}",
                  style: TextStyle(fontSize: 19.5,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500
                  ),),
                  subtitle: Text("${_features[index]['properties']['place']}",
                  style: TextStyle(fontSize: 14.5,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
                  ),
                  onTap: (){
                    _showAlertMessage(context,"${_features[index]['properties']['type']}");
                                      },
                                    );
                                    }
                                    
                               
                            ),
                          ),
                    
                           );
                      }
                    
                      void _showAlertMessage(BuildContext context, String message) {
                        var alert =  AlertDialog(
                            title: Text("Quakes"),
                            content: Text(message),
                            actions: <Widget>[
                              FlatButton(onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('Ok'),
                              )
                            ],
                        );

                        showDialog(context: context, builder: (BuildContext context) {
                          return alert;
                        },);

                      }
}
 
Future<Map> getQuakes() async {

    String apiUrl='https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);

}