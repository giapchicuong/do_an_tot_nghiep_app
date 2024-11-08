import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_repository.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_add_dto.dart';

import '../../result_type.dart';

class UserRatingGetBloc extends Bloc<UserRatingGetEvent, UserRatingGetState> {
  UserRatingGetBloc(this.versionRepository) : super(UserRatingGetInitial()) {
    on<UserRatingGetStarted>(_onUserRatingGetStarted);
    on<UserRatingAddStarted>(_onUserRatingAddStarted);
    on<UserRatingPostStarted>(_onUserRatingPostDataStarted);
  }

  final VersionRepository versionRepository;

  void _onUserRatingGetStarted(
      UserRatingGetStarted event, Emitter<UserRatingGetState> emit) async {
    emit(UserRatingGetInProgress());

    final result = await versionRepository.getUserRating();

    return (switch (result) {
      Success(data: final data) => emit(UserRatingGetSuccess(
          data: data, reviewOptions: [], rating: 0, isRating: false)),
      Failure() => emit(UserRatingGetFailure(result.message))
    });
  }

  void _onUserRatingAddStarted(
      UserRatingAddStarted event, Emitter<UserRatingGetState> emit) async {
    final currentState = state as UserRatingGetSuccess;
    final result = await versionRepository.addOptionRating(
      useRatingAddDto: UserRatingAdDto(
        userId: event.userId,
        versionId: event.versionId,
        rating: currentState.rating,
        reviewOptions: currentState.reviewOptions,
      ),
    );

    return (switch (result) {
      Success(data: final data) => emit(UserRatingGetSuccess(
          data: data, reviewOptions: [], rating: 0, isRating: true)),
      Failure() => emit(UserRatingGetFailure(result.message))
    });
  }

  void _onUserRatingPostDataStarted(
      UserRatingPostStarted event, Emitter<UserRatingGetState> emit) async {
    final currentState = state as UserRatingGetSuccess;

    final selectedOption = List<ReviewOptions>.from(currentState.reviewOptions);
    final isExitOption = selectedOption
        .any((option) => option.reviewOptionId == event.reviewOptionid);
    if (isExitOption) {
      selectedOption.removeWhere(
          (element) => element.reviewOptionId == event.reviewOptionid);
    } else {
      if (event.reviewOptionid != null) {
        selectedOption
            .add(ReviewOptions(reviewOptionId: event.reviewOptionid!));
      }
    }

    int rating = currentState.rating;

    if (event.rating != null) {
      rating = event.rating!;
    }

    return emit(UserRatingGetSuccess(
        data: currentState.data,
        reviewOptions: selectedOption,
        rating: rating,
        isRating: false));
  }
}
