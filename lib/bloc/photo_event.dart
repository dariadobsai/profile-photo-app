part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent extends Equatable {
  PhotoEvent([List props = const []]) : super();
}

class GetPhoto extends PhotoEvent {
  final File photo;

  GetPhoto(this.photo) : super([photo]);

  @override
  List<Object> get props => throw UnimplementedError();
}
