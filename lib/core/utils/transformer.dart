import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

EventTransformer<MapEvent> debounce<MapEvent>({
  Duration duration = const Duration(milliseconds: 350),
}) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
