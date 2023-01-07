import 'package:clean_code_project/features/posts/core/network/network_info.dart';
import 'package:clean_code_project/features/posts/data/dataSources/post_local_data.dart';
import 'package:clean_code_project/features/posts/data/dataSources/post_remote_data.dart';
import 'package:clean_code_project/features/posts/domain/repositories/post_repositories.dart';
import 'package:clean_code_project/features/posts/domain/useCases/add_post.dart';
import 'package:clean_code_project/features/posts/domain/useCases/delete_post.dart';
import 'package:clean_code_project/features/posts/domain/useCases/get_all_posts.dart';
import 'package:clean_code_project/features/posts/domain/useCases/update_post.dart';
import 'package:clean_code_project/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean_code_project/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'features/posts/data/repositories/post_repo_impl.dart';

final  sl=GetIt.instance;

Future<void> init() async{

  //feature post

  //bloc

  sl.registerFactory(() => PostsBloc(getPosts: sl()));

  sl.registerFactory(() => AddDeleteUpdateBloc(updatepost:sl(), deletepost:sl(), addpost:sl()));


  //use cases

  sl.registerLazySingleton(() => GetAllPostsUserCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));


  //repositories

  sl.registerLazySingleton<PostRepositories>(() =>PostRepoImpl(remoteDataSource: sl(), localDataSource: sl(), network: sl()) );


  //datasources

  sl.registerLazySingleton<PostRemoteDataSource>(() =>PostRemoteDataSourceImpl(client: sl()) );

  sl.registerLazySingleton<PostLocalDataSource>(() =>PostLocalDataSourceImpl(shared: sl()));




  //core

sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
//externel
final sharedPrefrences =await SharedPreferences.getInstance();

sl.registerLazySingleton(() => sharedPrefrences);
sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());







}