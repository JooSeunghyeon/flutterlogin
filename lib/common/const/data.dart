import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
final emulatorIp = '172.30.1.70:3000'; // 디바이스 연결해서 사용하는경우 같은 와이파이 영역대 잡아두기.
// final emulatorIp = '172.20.10.5:3000'; // 내 핫프사
final simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final storge = FlutterSecureStorage();