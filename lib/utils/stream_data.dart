import 'dart:async';

class StreamData<T> {
  late final StreamController<T> _controller;
  Stream<T> get stream => _controller.stream;

  late T _value;
  T get value => _value;

  StreamData({
    required T initialValue,
    bool broadcast = false
  }) {
    if(broadcast) {
      _controller = StreamController<T>.broadcast();
    } else {
      _controller = StreamController<T>();
    }
    _value = initialValue;
  }

  add(T newValue) {
    _controller.add(newValue);
    _value = newValue;
  }

  emptyCall() {
    _controller.add(_value);
  }

  close() {
    _controller.close();
  }
}