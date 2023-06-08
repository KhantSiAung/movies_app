// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:movies_application/model.dart';
import 'package:http/http.dart' as http;
class NetworkCall{
  Future<MoviesData>fetchMoviesData({required int page})async{  //domain               //path                   //atribute
    final response= await http.get(Uri.parse('https://yts.torrentbay.to/api/v2/list_movies.json?page=$page'));
    if(response.statusCode==200){              
      final data = moviesDataFromJson(response.body);
      print(response.body);
      print(data);
      return data;
    }else{throw Exception('Fail to load problam');}
  }
  
}