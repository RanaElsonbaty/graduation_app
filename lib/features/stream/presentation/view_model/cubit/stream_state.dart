import 'package:graduation/features/stream/data/model/stream_model.dart';

abstract class StreamState {}

class StreamInitial extends StreamState {}

class StreamLoading extends StreamState {}

class StreamSuccess extends StreamState {
  final StreamModel streamModel;
  StreamSuccess(this.streamModel);
}

class StreamEmpty extends StreamState {}

class StreamError extends StreamState {
  final String message;
  StreamError(this.message);
}
