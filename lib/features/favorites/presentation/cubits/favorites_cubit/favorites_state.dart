part of 'favorites_cubit.dart';

extension FavoritesStateX on FavoritesState {
  bool get isInitial => status == GenericStateStatus.initial;
  bool get isLoading => status == GenericStateStatus.loading;
  bool get isLoaded => status == GenericStateStatus.loaded;
  bool get isError => status == GenericStateStatus.error;
}

@immutable
class FavoritesState extends Equatable {
  const FavoritesState({
    required this.status,
    this.favorites = const <BranchesResponseModel>[],
    this.favoriteIds = const <String>{},
    this.errorMsg,
  });

  final GenericStateStatus status;
  final List<BranchesResponseModel> favorites;

  final Set<String> favoriteIds;
  final String? errorMsg;

  bool isFavorite(String branchId) => favoriteIds.contains(branchId);

  FavoritesState copyWith({
    GenericStateStatus? status,
    List<BranchesResponseModel>? favorites,
    Set<String>? favoriteIds,
    String? errorMsg,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, favorites, favoriteIds, errorMsg];
}
