import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/sql.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  TextEditingController note = TextEditingController();
  Sql data = Sql();
  bool isDone = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Sql>(
        builder: (context, jo, child) {
          return SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/pic.png'),
                    const Positioned(
                      right: 28,
                      top: 114,
                      child: Text(
                        "Thur 9",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "RussoOne",
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    const Positioned(
                      right: 28,
                      top: 125,
                      bottom: 13,
                      child: Text(
                        "6:23 AM",
                        style: TextStyle(
                            fontFamily: "RussoOne",
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 29),
                          child: TextField(
                            controller: note,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                fillColor: Color(0xFFEBEFF2),
                                filled: true,
                                hintText: "Note",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF888888))),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10, right: 28),
                        height: 49,
                        decoration: BoxDecoration(
                          color: const Color(0xFF20EEB0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                jo.insert(note.text);
                                jo.read();
                                setState(() {
                                  note.text = "";
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: 1,
                            ),
                            IconButton(
                              onPressed: () {
                                jo.read();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 29),
                    child: ListView.builder(
                      itemCount: jo.allData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                            value: isDone,
                            onChanged: (value) {
                              isDone = value!;
                              setState(() {});
                            },
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                jo.delete(jo.allData[index]['id']);
                                jo.read();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          subtitle: const Text(
                            "Today at 8:00 PM",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF888888)),
                          ),
                          title: Text(
                            jo.allData[index]['text'].toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
