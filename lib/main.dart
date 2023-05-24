import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOfFacts;

  Future fetchData() async {
    http.Response response;
    response =
        await http.get('https://thegrowingdeveloper.org/apiview?id=2' as Uri);
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        listResponse = json.decode(response.body);
        listOfFacts = mapResponse!['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data from internet'),
        backgroundColor: Colors.blue[980],
      ),
      body: mapResponse == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(mapResponse!['category'].toString(),
                      style: const TextStyle(
                        fontSize: 30,
                      )
                      // stringResponse.toString(),

                      ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Image.network(listOfFacts![index]['image_url']),
                            Text(listOfFacts![index]['title'].toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                )
                                // stringResponse.toString(),

                                ),
                          ],
                        ),
                      );
                    },
                    itemCount: listOfFacts == null ? 0 : listOfFacts!.length,
                  ),
                ],
              ),
            ),
    );
  }
}
