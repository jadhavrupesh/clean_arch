import 'package:dio/dio.dart'; // Imports Dio for HTTP requests
import 'package:injectable/injectable.dart'; // Imports injectable for dependency injection
import 'package:retrofit/retrofit.dart'; // Imports Retrofit for declarative API definition
import '../../models/post_model.dart'; // Imports the data model for posts

// This line is required by the build_runner to generate the implementation file.
part 'api_service.g.dart';

@injectable
@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService; // <-- Remove the baseUrl parameter here

  @GET("/posts")
  Future<List<PostModel>> getPosts();

// ... other methods
}