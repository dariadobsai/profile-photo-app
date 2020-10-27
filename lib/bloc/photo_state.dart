part of 'photo_bloc.dart';

@immutable
abstract class PhotoState extends Equatable {
  const PhotoState([List props = const []]) : super();
}

class PhotoInitial extends PhotoState {
  @override
  List<Object> get props => this.props;
}

class PhotoSet extends PhotoState {
  final File photo;

  PhotoSet(this.photo) : super([photo]);

  // TODO: it wasn't updating, solution -> https://github.com/felangel/bloc/issues/1090
  @override
  List<Object> get props => [photo];
}
