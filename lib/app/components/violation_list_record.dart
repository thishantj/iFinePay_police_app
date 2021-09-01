import 'package:flutter/material.dart';
import './custom_icon.dart';

class ViolationListRecord extends StatelessWidget {
  const ViolationListRecord({
    Key key,
    @required this.violationId,
    this.price,
  }) : super(key: key);

  final String violationId;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          color: Colors.blue[300],
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
                    violationId,
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
                          price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomIcon(
                  svgIcon: "assets/icons/right-arrow.svg",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
