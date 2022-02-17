import 'package:flutter/material.dart';
import 'package:myapp/screens/charaScreen.dart';

// ignore: camel_case_types
class homeContent extends StatefulWidget {
  @override
  State<homeContent> createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images6.alphacoders.com/909/thumb-1920-909641.png"),
            fit: BoxFit.cover,
          ),
        )),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Rick And Morty",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText:
                              'Enter Password...in case you forgot, it\'s abc123...',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value != 'abc123' ||
                              value == null ||
                              value.isEmpty) {
                            return 'Invalid Pass';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => charaScreen()),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ))
              /* ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => charaScreen()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: const Text("Start",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ), */
            ],
          ),
        )
      ]),
    );
  }
}
