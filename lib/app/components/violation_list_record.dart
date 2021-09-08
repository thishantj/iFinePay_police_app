import 'package:flutter/material.dart';

class ViolationListRecord extends StatefulWidget {
  const ViolationListRecord({
    Key key,
    @required this.violationId,
    this.price,
    this.payment,
  }) : super(key: key);

  final String violationId;
  final String price;
  final String payment;

  @override
  _ViolationListRecordState createState() => _ViolationListRecordState();
}

class _ViolationListRecordState extends State<ViolationListRecord> {
  Color bgColor;
  Icon paymentIcon;

  @override
  void initState() {
    super.initState();
    if(widget.payment == "paid")
    {
      setState(() {
        bgColor = Colors.greenAccent;
        paymentIcon = Icon(
          Icons.check_circle, 
          color: Colors.green,
          size: 50,
        );
      });
    }
    else
    {
      setState(() {
        bgColor = Colors.redAccent;
        paymentIcon = Icon(
          Icons.do_not_disturb_on_rounded, 
          color: Colors.redAccent,
          size: 50,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          color: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    widget.violationId,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
                paymentIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ViolationListRecord extends StatefulWidget {
  const ViolationListRecord({
    Key key,
    @required this.violationId,
    this.price,
    this.payment,
  }) : super(key: key);

  final String violationId;
  final String price;
  final String payment;

  @override
  _ViolationListRecordState createState() => _ViolationListRecordState();
}

class _ViolationListRecordState extends State<ViolationListRecord> {
  Color bgColor;
  Icon paymentIcon;

  @override
  void initState() {
    super.initState();
    if(widget.payment == "paid")
    {
      setState(() {
        bgColor = Colors.greenAccent;
        paymentIcon = Icon(
          Icons.check_circle, 
          color: Colors.green,
          size: 50,
        );
      });
    }
    else
    {
      setState(() {
        bgColor = Colors.redAccent;
        paymentIcon = Icon(
          Icons.do_not_disturb_on_rounded, 
          color: Colors.redAccent,
          size: 50,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          color: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    widget.violationId,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
                paymentIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
