import 'package:dartz/dartz.dart';
import 'package:dev_ideas/core/errors/failures.dart';
import 'package:dev_ideas/core/usecases/usecase.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/add_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_all_ideas.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_idea_by_filter.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/get_specific_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/remove_idea.dart';
import 'package:dev_ideas/features/dev_projects/domain/usecases/update_idea.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/dev_projects_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetAllIdeas extends Mock implements GetAllIdeas {}

class MockGetIdeasByFilter extends Mock implements GetIdeasByFilter {}

class MockGetSpecificIdea extends Mock implements GetSpecificIdea {}

class MockRemoveIdea extends Mock implements RemoveIdea {}

class MockUpdateIdea extends Mock implements UpdateIdea {}

void main() {
  DevProjectsBloc bloc;

  MockGetAllIdeas getAllIdeas;
  MockGetIdeasByFilter getIdeasByFilter;
  MockGetSpecificIdea getSpecificIdea;

  final tIdeaFirst = Idea(
      id: "123",
      title: "Test",
      projectName: "Test1",
      description: "",
      photoURLs: [],
      category: "Category1",
      status: DevStatus.FINISHED);

  final tIdeaSecond = Idea(
      id: "234",
      title: "Test1",
      projectName: "Test2",
      description: "",
      photoURLs: [],
      category: "Category2",
      status: DevStatus.DEVELOPMENT);

  final tIdeaThird = Idea(
      id: "345",
      title: "Test2",
      projectName: "Test3",
      description: "",
      photoURLs: [],
      category: "Category3",
      status: DevStatus.IDEA);

  final tIdeasList = ([
    tIdeaFirst,
    tIdeaSecond,
    tIdeaThird,
  ]);

  setUp(() {
    getAllIdeas = MockGetAllIdeas();
    getIdeasByFilter = MockGetIdeasByFilter();
    getSpecificIdea = MockGetSpecificIdea();

    bloc = DevProjectsBloc(
        getAllIdeas: getAllIdeas,
        getSpecificIdea: getSpecificIdea,
        getIdeasByFilter: getIdeasByFilter);
  });

  test("inital state should be InitialDevProjectsBlocState", () async {
    expect(bloc.initialState, equals(EmptyDevProjectsBlocState()));
  });

  group("LoadDevProjects", () {
    test("should displach LoadedDevProjectsState", () async {
      when(getAllIdeas(any)).thenAnswer((_) => Future.value(Right(tIdeasList)));

      //assert later
      final expectedStates = [
        EmptyDevProjectsBlocState(),
        LoadedDevProjectsState(ideas: tIdeasList)
      ];
      expectLater(bloc.state, emitsInOrder(expectedStates));

      bloc.dispatch(LoadDevProjectsEvent());

      await untilCalled(getAllIdeas(any));
      verify(getAllIdeas(any));
    });

    test(
        "should displach ErrorDevProjectsState when ann error in the usecase occors",
            () async {
          when(getAllIdeas(any))
              .thenAnswer((_) => Future.value(Left(CacheFailure())));

          final expectedStates = [
            EmptyDevProjectsBlocState(),
            ErrorDevProjectsState(error: "TODO")
          ]; //TODO implement error
          expectLater(bloc.state, emitsInOrder(expectedStates));

          bloc.dispatch(LoadDevProjectsEvent());

          await untilCalled(getAllIdeas(any));
          verify(getAllIdeas(any));
        });
  });

  group("LoadDevProjectsWithFilterEvent", () {
    final tTitle = "Title",
        tProjectName = "",
        tCategory = "",
        tDevStatus = DevStatus.IDEA;
    test("should dispach LoadedDevProjectsWithFilterState for a filter",
            () async {
          when(getIdeasByFilter(any))
              .thenAnswer((_) => Future.value(Right(tIdeasList)));

          final expectedStates = [
            EmptyDevProjectsBlocState(),
            LoadedDevProjectsWithFilterState(
                title: tTitle,
                projectName: tProjectName,
                category: tCategory,
                devStatus: tDevStatus,
                ideas: tIdeasList)
          ];
          expectLater(bloc.state, emitsInOrder(expectedStates));

          bloc.dispatch(LoadDevProjectsWithFilterEvent(
              title: tTitle,
              projectName: tProjectName,
              category: tCategory,
              devStatus: tDevStatus));

          await untilCalled(getIdeasByFilter(any));
          verify(getIdeasByFilter(any));
        });

    test("should dispach ErrorDevProjectsState", () async {
      when(getIdeasByFilter(any))
          .thenAnswer((_) => Future.value(Left(CacheFailure())));

      final expectedStates = [
        EmptyDevProjectsBlocState(),
        ErrorDevProjectsState(error: "TODO")
      ]; //TODO implement error

      expectLater(bloc.state, emitsInOrder(expectedStates));

      bloc.dispatch(LoadDevProjectsWithFilterEvent(
          title: tTitle,
          projectName: tProjectName,
          category: tCategory,
          devStatus: tDevStatus));

      await untilCalled(getIdeasByFilter(any));
      verify(getIdeasByFilter(any));
    });
  });
}
