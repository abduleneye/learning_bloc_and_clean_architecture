abstract class CountDownEvent {}

class StartCountDown extends CountDownEvent {
  final int countUntill;
  StartCountDown({required this.countUntill});
}

class InitializeCountDown extends CountDownEvent {}
