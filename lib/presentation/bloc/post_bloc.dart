import 'package:bloc/bloc.dart';
import 'package:clean_arch/di/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/domain/entities/post.dart';
import 'package:injectable/injectable.dart'; // <-- Import injectable
import '../../domain/usecases/get_posts_use_case.dart';
import '../../core/error/failures.dart';

part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

@injectable // <-- Add this annotation
class PostBloc extends Bloc<PostEvent, PostState> {
  // You can remove this line now, as injectable will handle injecting it via the constructor
  // final GetPostsUseCase getPosts = getIt<GetPostsUseCase>();

  final GetPostsUseCase _getPosts; // Make it private

  // Modify the constructor to accept the dependency
  PostBloc(this._getPosts) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      // Use the injected use case
      final failureOrPosts = await _getPosts(NoParams());
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
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}