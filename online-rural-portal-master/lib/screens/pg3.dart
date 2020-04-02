import 'package:flutter/material.dart';

class Pg3 extends StatefulWidget {
  @override
  _Pg3State createState() => _Pg3State();
}

class _Pg3State extends State<Pg3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
          Text('ELECTRICITY',
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
            padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child:
            Text(
              'For electricity problems like:\n'
              'Shortage of electric supply in a particular area\n'
              'power shutdown\n'
              'mishandles electric wires or poles\netc....\n',
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
                  'contact Rupnagar complaint center of punjab state power control corporation(PSPCL)\n'
                  'contact number: 01881-222259,96466-98324\n\n'
                  'Emergency number for power cutdown: 1912\n\n'
                  'Link for advance bill payment:  https://billpayment.pspcl.in/pgBillPay.aspx?uc=BillPayAdvance',
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