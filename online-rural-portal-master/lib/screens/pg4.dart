import 'package:flutter/material.dart';

class Pg4 extends StatefulWidget {
  @override
  _Pg4State createState() => _Pg4State();
}

class _Pg4State extends State<Pg4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
          Text('HEALTH',
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
              'List of helpline numbers for various health problems:\n',
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
            Text(
                  'Medical Consultation-Health: 104\n\n'
                  'Ambulance-Health: 108\n\n'
                  'Tuberculosis: 18001216666\n\n'
                  'Tobacco Control: 1800110456\n\n'
                  'NRI Helpline: 0091-172-2298543\n\n'
                  'Rural water supply and Sanitation: 1800-180-2468\n\n'
                  'Urban Water supply and Sanitation: 1800-1800-0172\n\n'
                  'Excise: 	18002582580\n\n'
                  'Women and Children: 1091',
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