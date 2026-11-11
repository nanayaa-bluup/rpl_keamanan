import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';

class DependencyInjector extends InheritedWidget {
  final ApiService apiService;
  final UserRepository userRepository;
  final PostRepository postRepository;

  static final ApiService _singletonApiService = ApiService();

  DependencyInjector({
    super.key,
    required super.child,
    ApiService? apiService,
    UserRepository? userRepository,
    PostRepository? postRepository,
  })  : apiService = apiService ?? _singletonApiService,
        userRepository = userRepository ??
            UserRepositoryImpl(apiService: apiService ?? _singletonApiService),
        postRepository = postRepository ??
            PostRepositoryImpl(apiService: apiService ?? _singletonApiService);

  /// Method static untuk mengakses DependencyInjector dari BuildContext
  static DependencyInjector of(BuildContext context) {
    final DependencyInjector? result =
        context.dependOnInheritedWidgetOfExactType<DependencyInjector>();
    assert(result != null, 'No DependencyInjector found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DependencyInjector oldWidget) => false;
}