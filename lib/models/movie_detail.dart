// 1) Create the class
class MovieDetail {
  // 2) Create the properties
  final String title;
  final String imdbId;
  final String poster;
  final String year;
  final String released;
  final String genre;
  final String actors;
  final String writer;
  final String plot;

  // 3) Create the constructor

MovieDetail({required this.title, required this.imdbId, required this.poster,
required this.year, required this.released, required this.genre, required this.actors,
required this.writer, required this.plot});

// 4) JSON to Object Transformer

factory MovieDetail.fromJson(Map<String, dynamic> json){
  return MovieDetail(title: json["Title"],
  imdbId: json["imdbID"], poster: json["Poster"],
      year: json["Year"], released: json["Released"], genre: json["Genre"],
      actors: json["Actors"], writer: json["Writer"], plot: json["Plot"]);
  }

}