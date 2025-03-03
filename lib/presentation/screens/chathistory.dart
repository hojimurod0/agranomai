import 'package:agranomai/presentation/screens/first_screen.dart';

import 'package:flutter/material.dart';

class Chathistory extends StatefulWidget {
  const Chathistory({super.key});

  @override
  State<Chathistory> createState() => _ChathistoryState();
}

class _ChathistoryState extends State<Chathistory> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat History",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_sharp, size: 30, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,

          itemCount: 6,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/insate.png'),
              ),

              title: Text('Meva pashshalari'),
              subtitle: Text('20 Sep 2023 '),
              trailing: Text('12:00'),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.green, blurRadius: 10, spreadRadius: 4),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if (index == 0) return FirstScreen();
                  // if (index == 1) return ImagePickerScreen();
                  if (index == 1) return Chathistory();
                  return FirstScreen();
                },
              ),
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstScreen()),
                  );
                },
                child: Icon(Icons.home, size: 30),
              ),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (Chathistory())),
                  );
                },
                child: Icon(Icons.history, size: 30),
              ),
              label: 'Tarix',
            ),
          ],
        ),
      ),
    );
  }
}
