import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  Future<List<dynamic>> fetchMovies() async {
    var url = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=4113f3ad734e747a5b463cde8c55de42&language=en-US&page=2"));
    var jsonData = json.decode(url.body);
    return jsonData["results"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Movies",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      height: 250,
                      alignment: Alignment.centerLeft ,
                      child: Card(
                        child: Image.network("https://image.tmdb.org/t/p/w500" +
                            snapshot.data?[index]["poster_path"]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              snapshot.data?[index]["original_title"],
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data?[index]["release_date"],
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data?[index]["overview"],
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
