part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState([
    @Default({}) Map<String, RelationUser> friendsList,
    @Default(PageState.withOutAnimation(0)) PageState page,
    String? currentSelectedChannel,
  ]) = _HomeState;

  Iterable<RelationUser> get friends {
    return friendsList.values
        .where((user) => user.relationStatus == RelationStatus.friend);
  }

  Iterable<RelationUser> get incomingFriends {
    return friendsList.values
        .where((user) => user.relationStatus == RelationStatus.incoming);
  }
}

@freezed
class PageState with _$PageState {
  const factory PageState.withAnimation(int pageNumber) = PageStateWithAnimation;
  const factory PageState.withOutAnimation(int pageNumber) = PageStateWithOutAnimation;
}
