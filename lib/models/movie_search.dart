//1 ) Create the Class
 class MovieSearch {
  // 2) Create the properties of the class - What you show on the UI
  final String title;
  final String imdbId;
  final String poster;
  final String year;

  // 3) Create the consructor of the class
 MovieSearch({required this.title, required this.imdbId, required this.poster, required this.year});

  //4) Create json (the response from API) to Object (An instance of MovieSearch) transformer
// left part is our naming convention
  // the right part [""] needs to be the same as Json
 factory MovieSearch.fromJson(Map<String,dynamic> json){
  return MovieSearch(title: json["Title"],
      imdbId: json["imdbID"], poster: json["Poster"],
      year: json["Year"]);
 }

// 5) Array of JSON, to List of Map transformer
  // I need to have this code if the JSON from API is sent in []
  static List<MovieSearch> moviesFromJson(dynamic json ){
  // The word "Search" here refers to the word "Search" in the API
   var searchResult = json["Search"];
   List<MovieSearch> results = List.empty(growable: true);

   if (searchResult != null){

    searchResult.forEach((v)=>{
     results.add(MovieSearch.fromJson(v))
    });
    return results;
   }
   return results;
  }


 }