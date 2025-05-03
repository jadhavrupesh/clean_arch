// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_arch/data/datasources/remote/api_service.dart' as _i59;
import 'package:clean_arch/data/repositories/post_repository_impl.dart'
    as _i399;
import 'package:clean_arch/di/register_module.dart' as _i918;
import 'package:clean_arch/domain/repositories/post_repository.dart' as _i758;
import 'package:clean_arch/domain/usecases/get_posts_use_case.dart' as _i843;
import 'package:clean_arch/presentation/bloc/post_bloc.dart' as _i881;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i59.ApiService>(() => _i59.ApiService(gh<_i361.Dio>()));
    gh.factory<_i758.PostRepository>(
      () => _i399.PostRepositoryImpl(remoteDataSource: gh<_i59.ApiService>()),
    );
    gh.factory<_i843.GetPostsUseCase>(
      () => _i843.GetPostsUseCase(gh<_i758.PostRepository>()),
    );
    gh.factory<_i881.PostBloc>(
      () => _i881.PostBloc(gh<_i843.GetPostsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i918.RegisterModule {}
