import 'package:flutter/material.dart';

class ItemListComponent extends StatelessWidget {
  const ItemListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(color: Colors.redAccent[700]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.more_vert_rounded),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Item name",style: TextStyle(
                      fontWeight: FontWeight.bold
                  )),
                  Text("Item price"),
                ],
              ),
            ],
          ),
          Text("Price",style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}
