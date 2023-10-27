import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:moive_details_api/models/TvModel.dart';
import 'package:riverpod/riverpod.dart';

import '../models/movies_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3/discover';
  final String movieUrl = '/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';
  final String tvUrl = '/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc';

  final options = Options(headers: {'accept':'application/json', 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZjZjMjc1YzM3NTEyMTRmNWM2NjQ1NTY1MWNiNDIyNyIsInN1YiI6IjY1MzM2YWU4NDJkODM3MDE0ZGI4ODZlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NuRGwS_c7uu1_f8SKl6y7rpU2wJJOzC9q96cgc98nWw'});

  List<MovieModel>movieDetails = [];
  List<TvModel>tvDetails = [];


  Future<List<MovieModel>> getMovieData() async{
    try{
      var response = await _dio.get('$baseUrl/$movieUrl',options: options);
     // print(response.statusCode);

      if(response.statusCode==200){
        if(response.data is Map<String,dynamic>){
          final jsonData = response.data as Map<String,dynamic>;
          if(jsonData.containsKey('results') && jsonData['results'] is List){
            final List data = jsonData['results'];
            movieDetails = data.map((value) => MovieModel.fromJson(value)).toList();
           // print(movieDetails.length.toString());
            return movieDetails;
          }
          else{
            throw Exception("Invalid data structure: 'data' key not found or not a List");
          }
        }
        else{
          throw Exception("Invalid data structure: Expected a map");
        }
        // List data = response.data;
        //
        // movieDetails = data.map((value) => MovieModel.fromJson(value)).toList();
        // print(movieDetails.length.toString());
      }
      else{
        return [];
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<TvModel>> getTvData() async{
    try{
      var response = await _dio.get('$baseUrl/$tvUrl',options: options);
      //print(response.statusCode);

      if(response.statusCode==200){
        if(response.data is Map<String,dynamic>){
          final jsonData = response.data as Map<String,dynamic>;
          if(jsonData.containsKey('results') && jsonData['results'] is List){
            final List data = jsonData['results'];
            tvDetails = data.map((value) => TvModel.fromJson(value)).toList();
            //print(tvDetails.length.toString());
          }
          else{
            print("j error");
          }
        }
        else{
          print("m error");
        }

      }
      else{
        print("nhi milega data");
      }
      return tvDetails;

    }catch(e){
      throw Exception(e.toString());
    }
  }

}

final apiServiceProvider = Provider<ApiServiceWithRiverpod>((ref) {
  return ApiServiceWithRiverpod();
},);  


class ApiServiceWithRiverpod{
  Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3/discover';
  final String movieUrl = '/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';
  final String tvUrl = '/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc';

  final options = Options(headers: {'accept':'application/json', 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZjZjMjc1YzM3NTEyMTRmNWM2NjQ1NTY1MWNiNDIyNyIsInN1YiI6IjY1MzM2YWU4NDJkODM3MDE0ZGI4ODZlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NuRGwS_c7uu1_f8SKl6y7rpU2wJJOzC9q96cgc98nWw'});


  List<MovieModel>movieDetails = [];
  List<TvModel>tvDetails = [];

  Future<void> getMovieData() async{
    try{
      final response = await _dio.get('$baseUrl$movieUrl',options: options);
      print(response.statusCode);
      
      if(response.statusCode==200){
        if(response.data is Map<String,dynamic>){
          final jsonData = response.data as Map<String,dynamic>;
          if(jsonData.containsKey('results') && jsonData['results'] is List){
            final List data = jsonData['results'];
            movieDetails = data.map((value) => MovieModel.fromJson(value)).toList();
            //print(tvDetails.length.toString());
          }
          else{
            print("j error");
          }
        }
        else{
          print("m error");
        }
      }
    }
    catch(e){
         print(e.toString());
    }
  }

  Future<List<TvModel>> getTvData() async{
    try{
      final response = await _dio.get('$baseUrl$movieUrl',options: options);

      print(response.statusCode);
      if(response.statusCode==200){
        if(response.data is Map<String,dynamic>){
          final jsonData = response.data as Map<String,dynamic>;
          if(jsonData.containsKey('results') && jsonData['results'] is List){
            final List data = jsonData['results'];
            tvDetails = data.map((value) => TvModel.fromJson(value)).toList();
            //print(tvDetails.length.toString());
          }
          else{
            print("j error");
          }
        }
        else{
          print("m error");
        }
      }
      return tvDetails;
    }
    catch(e,s){
     print(s.toString);
          throw Exception(e.toString());
    }
  }

}