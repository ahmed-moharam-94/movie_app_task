import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_task/core/constants/app_colors.dart';
import '../../../../../core/errors/snack_bar.dart';
import '../../../../../core/services/service_locator.dart';
import '../../blocs/movie_details_bloc.dart';
import '../widgets/movie_info_list_widget.dart';
import '../widgets/sliver_appbar_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late int movieId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoteArgs = ModalRoute.of(context)?.settings.arguments;
    if (modalRoteArgs != null) {
      movieId = modalRoteArgs as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MovieDetailsBloc>()..add(GetMovieDetailsEvent(movieId: movieId)),
      child: Scaffold(
        body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
          listener: (context, state) {
            if (state is ErrorMovieDetailsState)
              return SnackBarMessage()
                  .showErrorSnackBar(context, state.message);
          },
          builder: (context, state) {
            if (state is LoadingMovieDetailsState) {
              return SizedBox(
                  height: double.infinity,
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is ErrorMovieDetailsState) {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  if (state is LoadedMovieDetailsState)
                    SliverAppBarWidget(movieDetails: state.movieDetails),
                  if (state is LoadedMovieDetailsState)
                    MovieInfoListWidget(movieDetails: state.movieDetails),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
