import 'dart:async';
import 'dart:convert';

import 'package:myapp/screens/charaScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Character {
  final String name, status, image, url, species, gender;

  Character(
      this.name, this.status, this.image, this.url, this.species, this.gender);
//create fromJson method for Character class
  static Future<Character> fromJson(decode) {
    return Future.value(Character(decode['name'], decode['status'],
        decode['image'], decode['url'], decode['species'], decode['gender']));
  }
}

class CharaDetailScreen extends StatefulWidget {
  int charaId;

  CharaDetailScreen({Key? key, required this.charaId}) : super(key: key);
  @override
  _CharaDetailScreenApp createState() => _CharaDetailScreenApp();
}

class _CharaDetailScreenApp extends State<CharaDetailScreen> {
  Future<Character> fetchSingleCharacter() async {
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/${widget.charaId}'));
    if (response.statusCode == 200) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load character');
    }
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
              child: Center(
                  child: FutureBuilder(
                      future: fetchSingleCharacter(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data != null) {
                          return Card(
                              child: Column(
                            children: <Widget>[
                              Image.network(snapshot.data.image),
                              Text(snapshot.data.name),
                              Text('Status: ${snapshot.data.status}'),
                              Text('Species: ${snapshot.data.species}'),
                              Text('Gender: ${snapshot.data.gender}'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => charaScreen()));
                                },
                                child: Text('Back'),
                              )
                            ],
                          ));
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
