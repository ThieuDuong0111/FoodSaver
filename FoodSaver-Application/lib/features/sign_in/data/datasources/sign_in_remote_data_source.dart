abstract class SignInRemoteDataSource {}

// @LazySingleton(as: SignInRemoteDataSource)
// @RestApi()
// abstract class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
//   @factoryMethod
//   factory SignInRemoteDataSourceImpl(DioProvider dio) =>
//       _SignInRemoteDataSourceImpl(dio.create('Sign In API'), baseUrl: ApiEndpoints.baseUrl);

//   @override
//   @POST('/sign-in')
//   Future<SignInModel> signIn(
//     @Headers(<String, String>{
//       'Content-Type': 'application/json',
//     })
//     @Body()
//     SignInRequest signInRequest,
//   );
// }
