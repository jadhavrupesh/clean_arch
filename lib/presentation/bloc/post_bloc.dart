import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_arch/core/usecases/usecase.dart'; // Correct import
import 'package:clean_arch/domain/entities/post.dart'; // Correct import
import '../../domain/usecases/get_posts.dart';
import '../../core/error/failures.dart'; // Correct import

part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure'; // Added

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;

  PostBloc({required this.getPosts}) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      final failureOrPosts = await getPosts(NoParams());
      failureOrPosts.fold(
        (failure) => emit(PostError(message: _mapFailureToMessage(failure))),
        (posts) => emit(PostLoaded(posts: posts)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NetworkFailure: // Added
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
} 