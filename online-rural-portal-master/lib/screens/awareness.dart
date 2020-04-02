import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pg1.dart';
import 'package:flutter_app/screens/pg2.dart';
import 'package:flutter_app/screens/pg3.dart';
import 'package:flutter_app/screens/pg4.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('POSSIBLE PROBLEMS',
          style: TextStyle(

            fontWeight: FontWeight.bold,
            fontSize: 28.0,

          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Pg1()),
                  );
              },
              child: Text('COVID-19',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,

                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Pg2()),
                  );
              },
              child: Text('CRIME',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,

                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Pg3()),
                  );
              },
              child: Text('ELECTRICITY',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,

                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Pg4()),
                  );
              },
              child: Text('HEALTH',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,

                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
        ],
      ),
    );
  }
}