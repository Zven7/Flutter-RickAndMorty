import 'dart:async';
import 'dart:convert';

import 'package:myapp/screens/detailsPage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  /* final String name, email, userName;

  User(this.name, this.email, this.userName); */
  final String name, status, image, url;
  final int id;

  User(this.name, this.status, this.image, this.url, this.id);
}

//void main() => runApp(const charaScreen());

class charaScreen extends StatefulWidget {
  const charaScreen({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<charaScreen> {
  //Character fetching function
  Future fetchCharacters() async {
    var response =
        /* await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users')); */
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    var jsonData = jsonDecode(response.body);
    var resUx = jsonData['results'];
    /* List<User> users = []; */

    var charas = resUx
        .map((u) => User(u['name'], u['status'], u['image'], u['url'], u['id']))
        .toList();
    print("RES");
    print(charas[0].name);
    return charas;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rick & Morty Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 45, 243, 78),
            appBar: AppBar(
              title: const Text('Rick & Morty Flutter App'),
            ),
            body: Container(
              child: Card(
                  child: FutureBuilder(
                      future: fetchCharacters(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].status),
                                leading: CircleAvatar(
                                  child:
                                      Image.network(snapshot.data[index].image),
                                ),
                                onTap: () {
                                  print(snapshot.data[index].id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CharaDetailScreen(
                                                  charaId: snapshot
                                                      .data[index].id)));
                                },
                              );
                            },
                          );
                        } else {
                          return Container(
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      })),
            )));
  }
}
/* CODE FOR PASSING DATA
Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) => WelcomePage(
                                                                  name: _name.text,
                                                                  email: _email.text,
                                                                  phone: _phone.text)
                                                            )
                                             ); */

/* STACK */
/* body: Stack(
  children: [
    Container(
      color: Colors.black,
      width: 100,
      height: 100,
    ),
    )
    //similar to absolute
    Positioned(
      left: 100,
      top: 100,
      child: Icon(Icons.verified),
    ),

    //similar to relative
    Align(
      alignment: Alignment.topLeft,
      child: Icon(Icons.verified),
    ),
  ]
)
 */

/* FLOATING ACTION BTN*/
/* floatingActionButton: FloatingActionButton(
  onPressed: () {
    print('Pressed');
  },
  },
  child: Icon(Icons.add),
  backgroundColor: Colors.red,
) */

/* Bottom nav bar */
/* bottomNavigationBar: BottomNavigationBar(
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Search'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
  ],
  onTap: (int index) {
    print(index);
  },
) */

/* Drawer inside scaffold */
/* drawer: Drawer(
  child: ListView(
    children: const [
      DrawerHeader(
        child: Text('Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('Search'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
  ),
) */

/* ListView */
/* body: ListView(
  scrollDirection: Axis.horizontal,
  children: [
    Container(
      color: Colors.red,
      height: 100,
    ),
    Container(
      color: Colors.green,
      height: 100,
    ),
    Container(
      color: Colors.blue,
      height: 100,
    ),
  ],
) */

/* dynamic build with ListView */
/* body: ListView.builder(
  itemCount: 100,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      color: Colors.red,
      height: 100,
    );
  },
) */

/* Stateful Widget, refactor with ctrl + .*/
/* class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
*/

/* Reading a value from State ==> ${count}*/
/* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: Text(
            'You have pushed the button this many times: ${count}',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
} 
*/

/* Fetching data from a db  */
/* 
@override
void initState() {
  super.initState();
  fetchData();
}
 */

/* Dispose state */
/* @override
void dispose() {
  super.dispose();
  _controller.dispose();
}
 */

/* Navigation */
/* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
            child: Text('Go to second screen'),
          ),
        ),
      ),
    );
  }
}
*/

/* Hero widget */
/* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: IconButton(
          icon: Hero(
            tag: img,
            child: Image.network(img),
          ),
        ),
      ),
    );
  }
}*/

/* Getting the img from before to become hero of 2nd page */
/* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Hero(
            tag: img,
            child: Image.network(img),
          ),
        ),
      ),
    );
  }
}*/