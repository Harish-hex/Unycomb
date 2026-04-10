import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:nexus/data/local/daos/opportunity_dao.dart';
import 'package:nexus/data/local/daos/project_dao.dart';
import 'package:nexus/data/local/daos/task_dao.dart';
import 'package:nexus/data/local/daos/user_dao.dart';
import 'package:nexus/data/local/nexus_database.dart';
import 'package:nexus/data/network/dio_client.dart';
import 'package:nexus/data/network/websocket_client.dart';
import 'package:nexus/data/repositories/auth_repository_impl.dart';
import 'package:nexus/data/repositories/feed_repository_impl.dart';
import 'package:nexus/data/repositories/matching_repository_impl.dart';
import 'package:nexus/data/repositories/project_repository_impl.dart';
import 'package:nexus/data/repositories/user_repository_impl.dart';
import 'package:nexus/data/services/notification_service.dart';
import 'package:nexus/domain/repositories/auth_repository.dart';
import 'package:nexus/domain/repositories/feed_repository.dart';
import 'package:nexus/domain/repositories/matching_repository.dart';
import 'package:nexus/domain/repositories/project_repository.dart';
import 'package:nexus/domain/repositories/user_repository.dart';
import 'package:nexus/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:nexus/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:nexus/features/home/presentation/cubit/home_cubit.dart';
import 'package:nexus/features/matching/presentation/cubit/matching_cubit.dart';
import 'package:nexus/features/matching/presentation/cubit/realtime_match_cubit.dart';
import 'package:nexus/features/mentorship/presentation/cubit/mentorship_cubit.dart';
import 'package:nexus/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:nexus/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nexus/features/projects/presentation/cubit/kanban_cubit.dart';
import 'package:nexus/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt
    ..registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new)
    ..registerLazySingleton<MockAppStore>(MockAppStore.new)
    ..registerLazySingleton<NexusDatabase>(NexusDatabase.new)
    ..registerLazySingleton<UserDao>(UserDao.new)
    ..registerLazySingleton<ProjectDao>(ProjectDao.new)
    ..registerLazySingleton<TaskDao>(TaskDao.new)
    ..registerLazySingleton<OpportunityDao>(OpportunityDao.new)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        appStore: getIt<MockAppStore>(),
        secureStorage: getIt<FlutterSecureStorage>(),
      ),
    )
    ..registerLazySingleton<Dio>(() => createDioClient(getIt<AuthRepository>()))
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        appStore: getIt<MockAppStore>(),
        userDao: getIt<UserDao>(),
      ),
    )
    ..registerLazySingleton<MatchingRepository>(
      () => MatchingRepositoryImpl(appStore: getIt<MockAppStore>()),
    )
    ..registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(
        appStore: getIt<MockAppStore>(),
        opportunityDao: getIt<OpportunityDao>(),
      ),
    )
    ..registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(
        appStore: getIt<MockAppStore>(),
        projectDao: getIt<ProjectDao>(),
        taskDao: getIt<TaskDao>(),
      ),
    )
    ..registerLazySingleton<WebSocketClient>(WebSocketClient.new)
    ..registerLazySingleton<NotificationService>(NotificationService.new)
    ..registerFactory<OnboardingCubit>(
      () => OnboardingCubit(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        userRepository: getIt<UserRepository>(),
        matchingRepository: getIt<MatchingRepository>(),
        feedRepository: getIt<FeedRepository>(),
        projectRepository: getIt<ProjectRepository>(),
      ),
    )
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(userRepository: getIt<UserRepository>()),
    )
    ..registerFactory<MatchingCubit>(
      () => MatchingCubit(matchingRepository: getIt<MatchingRepository>()),
    )
    ..registerFactory<RealtimeMatchCubit>(
      () => RealtimeMatchCubit(webSocketClient: getIt<WebSocketClient>()),
    )
    ..registerFactory<FeedCubit>(
      () => FeedCubit(feedRepository: getIt<FeedRepository>()),
    )
    ..registerFactory<ChatCubit>(
      () => ChatCubit(appStore: getIt<MockAppStore>()),
    )
    ..registerFactory<ProjectsCubit>(
      () => ProjectsCubit(projectRepository: getIt<ProjectRepository>()),
    )
    ..registerFactory<KanbanCubit>(
      () => KanbanCubit(projectRepository: getIt<ProjectRepository>()),
    )
    ..registerFactory<MentorshipCubit>(
      () => MentorshipCubit(appStore: getIt<MockAppStore>()),
    );
}
