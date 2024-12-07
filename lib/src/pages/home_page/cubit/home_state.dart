part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {

  const HomeState._();

  const factory HomeState([@Default({}) Map<String,RelationUser> friendsList]) = _HomeState;

   Iterable<RelationUser> get friends {
   return friendsList.values.where((user)=>user.relationStatus == RelationStatus.friend);
  }

  Iterable<RelationUser> get incomingFriends {
   return friendsList.values.where((user)=>user.relationStatus == RelationStatus.incoming);
  }
}
