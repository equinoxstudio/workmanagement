import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WorkmanagementFirebaseUser {
  WorkmanagementFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

WorkmanagementFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WorkmanagementFirebaseUser> workmanagementFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<WorkmanagementFirebaseUser>(
            (user) => currentUser = WorkmanagementFirebaseUser(user));
