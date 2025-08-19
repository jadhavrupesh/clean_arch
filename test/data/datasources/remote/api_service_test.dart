import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:clean_arch/data/datasources/remote/api_service.dart';
import 'package:clean_arch/data/models/post_model.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
  });

  group('ApiService', () {
    const tPostModelList = [
      PostModel(
        userId: 1,
        id: 1,
        title:
            'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
        body:
            'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
      ),
      PostModel(
        userId: 1,
        id: 2,
        title: 'qui est esse',
        body:
            'est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla',
      ),
    ];

    group('getPosts', () {
      test('should perform a GET request on the /posts endpoint', () async {
        // arrange
        final responseData = [
          {
            'userId': 1,
            'id': 1,
            'title':
                'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
            'body':
                'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
          },
          {
            'userId': 1,
            'id': 2,
            'title': 'qui est esse',
            'body':
                'est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla',
          },
        ];

        when(mockDio.get('/posts')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act
        final result = await apiService.getPosts();

        // assert
        verify(mockDio.get('/posts'));
        expect(result, isA<List<PostModel>>());
        expect(result.length, 2);
        expect(result[0].id, 1);
        expect(result[1].id, 2);
      });

      test('should throw exception when the response is not 200', () async {
        // arrange
        when(mockDio.get('/posts')).thenThrow(
          DioException(
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/posts'),
            ),
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act & assert
        expect(() => apiService.getPosts(), throwsA(isA<DioException>()));
      });

      test('should throw exception when there is a network error', () async {
        // arrange
        when(mockDio.get('/posts')).thenThrow(
          DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act & assert
        expect(() => apiService.getPosts(), throwsA(isA<DioException>()));
      });
    });
  });
}
