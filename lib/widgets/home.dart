import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/widgets/detail.dart';

import '../models/movie_search.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var searchEditingController = TextEditingController();

  // By removing the mock data, the data type becomes List<MovieSearch>
  var _movies = [
    // {
    //   "Title": "Harry Potter and the Deathly Hallows: Part 2",
    //   "Year": "2011",
    //   "imdbID": "tt1201607",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Sorcerer's Stone",
    //   "Year": "2001",
    //   "imdbID": "tt0241527",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Prisoner of Azkaban",
    //   "Year": "2004",
    //   "imdbID": "tt0304141",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Chamber of Secrets",
    //   "Year": "2002",
    //   "imdbID": "tt0295297",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Goblet of Fire",
    //   "Year": "2005",
    //   "imdbID": "tt0330373",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Order of the Phoenix",
    //   "Year": "2007",
    //   "imdbID": "tt0373889",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BOTA3MmRmZDgtOWU1Ny00ZDc5LWFkN2YtNzNlY2UxZmY0N2IyXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Deathly Hallows: Part 1",
    //   "Year": "2010",
    //   "imdbID": "tt0926084",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Half-Blood Prince",
    //   "Year": "2009",
    //   "imdbID": "tt0417741",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNzU3NDg4NTAyNV5BMl5BanBnXkFtZTcwOTg2ODg1Mg@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "When Harry Met Sally...",
    //   "Year": "1989",
    //   "imdbID": "tt0098635",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMjE0ODEwNjM2NF5BMl5BanBnXkFtZTcwMjU2Mzg3NA@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Dirty Harry",
    //   "Year": "1971",
    //   "imdbID": "tt0066999",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMzdhMTM2YTItOWU2YS00MTM0LTgyNDYtMDM1OWM3NzkzNTM2XkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_SX300.jpg"
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex:2,
                child: TextField(
                  decoration: InputDecoration(hintText: "Enter movie to search"),
                  controller: searchEditingController,
                ),
              ),
              Expanded(
                  child: ElevatedButton(onPressed: () {
                    // Call the API, then, the response will be movies
                    // When we work with asynchronous function

                    // - var movies = await fetchMovies(searchEditingController.text)
                    // - fetchMovies().then()

                    fetchMovies(searchEditingController.text).then((movies){
                      setState(() {
                        _movies = movies;
                      });
                    });

                  }, child: Text("Search Movie")))
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_movies[index].title),
                      subtitle: Text(_movies[index].year),
                      leading: Image.network(_movies[index].poster),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>DetailPage(imdbId: _movies[index].imdbId,))
                        );
                        
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  // Future means this is an asynchronous method, something is running on the background
  // WHen I call this function, I need to either use async await or I need to use then

  // If you are working with an object {} -> Return type will be <ClassName>
  // If you are working with an array [] -> Return type will be List<ClassName>

  Future<List<MovieSearch>> fetchMovies(searchText) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // If you are working with object {} -> MovieSearch.fromJson [step 4]
      // If you are working with Array [] -> Movie.moviesFromJson [ step 5]
      return MovieSearch.moviesFromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
