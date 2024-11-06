import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_repository.dart';

import '../../result_type.dart';

class UserRatingGetBloc extends Bloc<UserRatingGetEvent, UserRatingGetState> {
  UserRatingGetBloc(this.versionRepository) : super(UserRatingGetInitial()) {
    on<UserRatingGetStarted>(_onUserRatingGetStarted);
  }

  final VersionRepository versionRepository;

  void _onUserRatingGetStarted(
      UserRatingGetStarted event, Emitter<UserRatingGetState> emit) async {
    emit(UserRatingGetInProgress());

    final result = await versionRepository.getUserRating();

    return (switch (result) {
      Success(data: final data) => emit(UserRatingGetSuccess(data: data)),
      Failure() => emit(UserRatingGetFailure(result.message))
    });
  }
}
