import 'package:flutter/material.dart';

class Pg2 extends StatefulWidget {
  @override
  _Pg2State createState() => _Pg2State();
}

class _Pg2State extends State<Pg2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
          Text('CRIME',
            style: TextStyle(
              color: Colors.amberAccent[200],
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red[600]
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child:
            Text(
              'one can contact policestation or on the helpline numbers provided for various types of crime\n\n'
              'List of helpline numbers for various crimes:\n',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18.0,

              ),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
            child:
            Text( 'general police helpline: 100\\181\n\n'
              'Rupnagar City police station: 01881-221177\n\n'
                  'Rupnagar Sadar: 01881-221178\n\n'
                  'Nangal police station: 	01887-223100\n\n'
                  'Nurpur Bedi: 	01887-240422\n\n'
                  'Fire: 101\n\n'
                  'Cyber crime helpline no: 0172-2226258\n\n'
                  'Kiratpur Sahib: 	01887-238622\n\n'
                  'Sri Anandpur Sahib: 01887-232027',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18.0,

              ),
            ),
          ),
        ],
      ),
    );
  }
}