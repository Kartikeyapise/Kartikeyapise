import 'package:flutter/material.dart';

class Pg1 extends StatefulWidget {
  @override
  _Pg1State createState() => _Pg1State();
}

class _Pg1State extends State<Pg1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
          Text('COVID-19',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
            child:
            Text(
              'SYMPTOMS:\n\n'
              '1.cough\n\n'
                  '2.fever\n\n'
                  '3.tiredness\n\n'
                  '4.difficulty breathing (severe cases)',
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
            padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,0.0),
            child:
            Text( 'PREVENTION:\n\n'
              '1.HANDSWash them often\n\n'
              '2.ELBOWCough into it\n\n'
              '3.FACEDon\'t touch it\n\n'
              '4.SPACEKeep safe distance\n\n'
              '5.HOMEStay if you can\n\n',
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