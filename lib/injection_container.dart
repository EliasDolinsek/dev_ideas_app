import 'package:get_it/get_it.dart';

import 'core/platform/data_manager.dart';
import 'features/dev_projects/data/datasources/dev_projects_local_datsource.dart';
import 'features/dev_projects/data/repositories/dev_projects_repository_default_impl.dart';
import 'features/dev_projects/domain/usecases/add_idea.dart';
import 'features/dev_projects/domain/usecases/get_all_ideas.dart';
import 'features/dev_projects/domain/usecases/get_idea_by_filter.dart';
import 'features/dev_projects/domain/usecases/remove_idea.dart';
import 'features/dev_projects/domain/usecases/update_idea.dart';
import 'features/dev_projects/presentation/bloc/bloc.dart';
import 'features/dev_projects/domain/repositories/dev_projects_repository.dart';

final GetIt sl = GetIt.instance;

void init() {
  //! Features - DevProjects
  //Bloc
  sl.registerFactory(() => DevProjectsBloc(
      getAllIdeas: sl(),
      getIdeasByFilter: sl(),
      addIdea: sl(),
      removeIdea: sl(),
      updateIdea: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAllIdeas(sl()));
  sl.registerLazySingleton(() => GetIdeasByFilter(sl()));
  sl.registerLazySingleton(() => AddIdea(sl()));
  sl.registerLazySingleton(() => RemoveIdea(sl()));
  sl.registerLazySingleton(() => UpdateIdea(sl()));
  
  //Repository
  sl.registerLazySingleton<DevProjectsRepository>(() => DevProjectsRepositoryDefaultImpl(localDataSource: sl()));

  //Data sources
  sl.registerLazySingleton<DevProjectsLocalDataSource>(() => DevProjectsLocalDataSourceDefaultImpl(sl()));

  //! Core
  sl.registerLazySingleton(() => LocalDataManager());
  
  //! External
}
