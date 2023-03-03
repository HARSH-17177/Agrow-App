import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jit_gaye_hackathon/screen/buyer_seller/Lender_borrower/add_borrow_item.dart';
import 'package:url_launcher/url_launcher.dart';

class LenderBorrower extends StatelessWidget {
  LenderBorrower({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  final Query<Map<String, dynamic>> _reference = FirebaseFirestore.instance
      .collection('borrow')
      .orderBy('timestamp', descending: true);

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow or Lend'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 10,
                        shadowColor: Colors.brown,
                        color: Colors.brown,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('${thisItem['user']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shadowColor: Colors.brown,
                        color: Colors.brown,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network('${thisItem['image']}'),
                        ),
                      ),
                      Card(
                          elevation: 10,
                          shadowColor: Colors.brown,
                          color: Colors.brown,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${thisItem['name']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${thisItem['quantity']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white)),
                              ),
                              InkWell(
                                onTap: () async {
                                  await canLaunch('${thisItem['url']}')
                                      ? launch('${thisItem['url']}')
                                      : print('Cant Open url');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Color.fromARGB(255, 4, 241, 12),
                                        size: 28,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Contact us',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  );

                  // return ListTile(
                  //   title: Text('${thisItem['name']}'),

                  //   subtitle: Image.network('${thisItem['image']}'),
                  //   // Text('${thisItem['name']}')
                  // );
                });
          }

          //Show loader
          return const Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const BorrowAdd()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
