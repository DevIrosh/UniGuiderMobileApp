import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nsbm/pages/SecondaryPages/libfloors/bookfloor.dart';
import 'package:nsbm/pages/SecondaryPages/libfloors/roombox.dart';

class GroundFloor extends StatefulWidget {
  GroundFloor({super.key, required this.day});
  String day;
  @override
  State<GroundFloor> createState() => _GroundFloorState();
}

int len = 4;

class _GroundFloorState extends State<GroundFloor> {
  List rooms = ["10", "15", "12", "16", "13", "17", "14", "18"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 245, 205),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 245, 205),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "NSBM Library Map",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  "Ground Floor",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    itemCount: rooms.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 70, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      bool sel = false;
                      return Center(
                        child: GestureDetector(
                          onTap: () async {
                            FirebaseFirestore.instance
                                .collection("rooms")
                                .where('id',
                                    isEqualTo: "${widget.day}:${rooms[index]}")
                                .get()
                                .then(
                              (QuerySnapshot querySnapshot) {
                                var docs = querySnapshot.docs;
                                print("len----> ${docs.length}");
                                if (docs.length == 0) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookFloor(
                                        day: widget.day,
                                        floor: "0",
                                        room: rooms[index],
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          color: Colors.white,
                                          height: 100,
                                          child: Center(
                                              child: Text(
                                                  "Already Booked ${widget.day}:${rooms[index]}")),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: RoomBox(
                            selected: sel,
                            nb: rooms[index].toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BookFloor(
                    //       day: widget.day,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 182, 46, 46)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                      child: Center(
                        child: Text(
                          "Got it",
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
