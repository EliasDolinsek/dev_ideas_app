import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/add_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/remove_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/update_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_all_ideas.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_idea_by_filter.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class DevProjectsBloc extends Bloc<DevProjectsEvent, DevProjectsState> {
  final GetAllIdeas getAllIdeas;
  final GetIdeasByFilter getIdeasByFilter;
  final AddIdea addIdea;
  final RemoveIdea removeIdea;
  final UpdateIdea updateIdea;

  DevProjectsBloc(
      {@required this.getAllIdeas,
      @required this.getIdeasByFilter,
      @required this.addIdea,
      @required this.removeIdea,
      @required this.updateIdea});

  @override
  DevProjectsState get initialState => EmptyDevProjectsBlocState();

  @override
  Stream<DevProjectsState> mapEventToState(
    DevProjectsEvent event,
  ) async* {
    if (event is LoadDevProjectsEvent) {
      final result = await getAllIdeas(NoParams());
      yield* result.fold((failure) async* {
        yield ErrorDevProjectsState(error: "TODO"); //TODO implement errors
      }, (ideasList) async* {
        yield LoadedDevProjectsState(ideas: ideasList);
      });
    } else if (event is LoadDevProjectsWithFilterEvent) {
      final result = await getIdeasByFilter(GetIdeasByFilterParams(
          title: event.title,
          category: event.category,
          devStatus: event.devStatus));

      yield* result.fold((failure) async* {
        yield ErrorDevProjectsState(error: "TODO"); //TODO implement errors
      }, (ideasFilteredList) async* {
        yield LoadedDevProjectsWithFilterState(
            title: event.title,
            projectName: event.projectName,
            category: event.category,
            devStatus: event.devStatus,
            ideas: ideasFilteredList);
      });
    } else if (event is AddIdeaEvent) {
      final result = await addIdea(AddIdeaParams(idea: event.idea));
      yield* result.fold((failure) async* {
        yield ErrorDevProjectsState(error: "TODO"); //TODO implement errors
      }, (_) async* {
        dispatch(LoadDevProjectsEvent());
      });
    } else if (event is RemoveIdeaEvent) {
      final result = await removeIdea(RemoveIdeaParams(ideaID: event.ideaID));
      yield* result.fold((failure) async* {
        yield ErrorDevProjectsState(error: "TODO"); //TODO implement errors
      }, (_) async* {
        dispatch(LoadDevProjectsEvent());
      });
    } else if(event is UpdateIdeaEvent){
      final result = await updateIdea(UpdateIdeaParams(ideaID: event.ideaID, update: event.idea));
      yield* result.fold((failure) async* {
        yield ErrorDevProjectsState(error: "TODO"); //TODO implement errors
      }, (_) async* {
        dispatch(LoadDevProjectsEvent());
      });
    }
  }
}
