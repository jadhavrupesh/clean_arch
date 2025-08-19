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
    return BlocProvider(
      create: (_) => getIt<PostBloc>()..add(FetchPosts()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Posts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.read<PostBloc>().add(FetchPosts());
                    },
                    tooltip: 'Refresh Posts',
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                return MessageDisplay(message: state.message);
              } else {
                // Should not happen
                return const MessageDisplay(message: 'Unexpected state');
              }
            },
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: () {
                  // Trigger a refresh to demonstrate network functionality with interceptors
                  context.read<PostBloc>().add(FetchPosts());
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                tooltip: 'Refresh with Network Demo',
                child: const Icon(Icons.refresh_rounded, size: 28),
              );
            },
          ),
        ),
      ),
    );
  }
}
