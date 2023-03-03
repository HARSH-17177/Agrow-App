import 'package:flutter/material.dart';
import 'package:jit_gaye_hackathon/screen/buyer_seller/Lender_borrower/lender_borrower_page.dart';
import 'package:jit_gaye_hackathon/screen/buyer_seller/grocerry/discussion_room.dart';

class Discussion extends StatelessWidget {
  const Discussion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Borrow or Lend",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LenderBorrower())),
            child: Container(
                margin:
                    const EdgeInsets.only(left: 45.0, right: 45, bottom: 10),
                child: Card(
                  shadowColor: Colors.brown,
                  color: Colors.brown,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset("images/tractor3.gif"),
                  ),
                )),
          ),
          const Text(
            "Grocerries",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ItemList())),
            child: Container(
                margin: const EdgeInsets.only(left: 45.0, right: 45),
                child: Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("images/unnamed.jpg"),
                    ))),
          )
        ],
      ),
    );
  }
}
