import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection_container.dart';
import '../bloc/post_bloc.dart';
import '../widgets/posts_list_widget.dart'; // We'll create this next
import '../widgets/loading_widget.dart'; // We'll create this next
import '../widgets/message_display.dart'; // We'll create this next

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocProvider(
        create: (_) => getIt<PostBloc>()..add(FetchPosts()), // Request initial data fetch
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              // Can show something initially or just let it transition to loading
              return const LoadingWidget();
            } else if (state is PostLoading) {
              return const LoadingWidget();
            } else if (state is PostLoaded) {
              return PostsListWidget(posts: state.posts);
            } else if (state is PostError) {
              return MessageDisplay(
                message: state.message,
              );
            } else {
              // Should not happen
              return const MessageDisplay(message: 'Unexpected state');
            }
          },
        ),
      ),
    );
  }
} 