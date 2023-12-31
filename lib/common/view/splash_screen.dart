import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState`
    super.initState();

    //deleteToken();
    checkToken();
  }

  void deleteToken() async {
    final storge = ref.read(secureStorageProvider);

    await storge.deleteAll();
  }

  void checkToken() async {
    final storge = ref.read(secureStorageProvider);

    final refreshToken = await storge.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storge.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try{
      // 해당 경로에서 토큰을 가지고 authorization에 Bearer 로 성공 여부를 판단한다.
      final resp = await dio.post('http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storge.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RootTab(), // 성공
          ),
              (route) => false);

    }catch(e){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(), // 실패
        ),
            (route) => false,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox()
            ],
          ),
        ));
  }
}
