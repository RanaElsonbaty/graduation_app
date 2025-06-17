import 'package:graduation/features/sections/data/model/section_model.dart';

abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoading extends SectionState {}

class SectionSuccess extends SectionState {
  final SectionModel sectionModel;

  SectionSuccess(this.sectionModel);
}

class SectionEmpty extends SectionState {}

class SectionError extends SectionState {
  final String message;

  SectionError(this.message);
}
