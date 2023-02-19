import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_task/core/constants/app_strings.dart';
import 'package:movies_app_task/core/errors/snack_bar.dart';
import 'package:movies_app_task/core/services/deeplink_service.dart';
import 'package:movies_app_task/movies/presentation/popular_movies_bloc/blocs/popular_movies_bloc.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../core/services/service_locator.dart';
import '../widgets/popular_movies_grid_widget.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    DeepLinkService.initURIHandler(context);
    DeepLinkService.incomingLinkHandler(context, _sub);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.popularMovies),
          actions: [
            IconButton(
                onPressed: _sendPushNotification,
                icon: const Icon(Icons.notifications)),
          ],
        ),
        body: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
          listener: (context, state) {
            if (state is ErrorPopularMoviesState) {
              SnackBarMessage().showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingPopularMoviesState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedPopularMoviesState) {
              return PopularMoviesGridWidget(movies: state.popularMovies);
            } else if (state is ErrorPopularMoviesState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(AppStrings.undefinedError));
            }
          },
        ),
      ),
    );
  }

  Future<void> _sendPushNotification() async {
    final deviceToken = await NotificationService().requestDeviceToken();
    if (deviceToken != null) {
      final String title = 'Test Push Notification';
      final String body =
          'This is a test push notification sent from the phone';
      final String type = 'Test';
      NotificationService()
          .sendPushNotification(title, body, deviceToken, type);
    }
  }
}
