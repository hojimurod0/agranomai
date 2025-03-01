import 'package:agranomai/presentation/screens/chathistory.dart';
import 'package:agranomai/presentation/screens/kameraScreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 10,
        title: Row(
          children: [
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/profil.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Xush kelibsiz, \n',
                  style: TextStyle(fontSize: 21, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Samuel Joe',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.settings, size: 30), onPressed: () {}),
            SizedBox(width: 10),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            margin: EdgeInsets.only(top: 3.0),
            child: Divider(height: 10, thickness: 3, color: Colors.orange[300]),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 45, vertical: 16),
              child: Text(
                '65 \n Rasm\nIzlangan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 250),
              child: Text(
                'Oxirgi qo\'shilganlar',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(2, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/images/insate.png',
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImagePickerScreen()),
          );
        },
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Colors.green,
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
            // BottomNavigationBarItem(
            //   icon: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => CameraScreen()),
            //       );
            //     },
            //     child: Icon(Icons.camera_alt_outlined, size: 30),
            //   ),
            //   label: 'Kamera',
            // ),
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
