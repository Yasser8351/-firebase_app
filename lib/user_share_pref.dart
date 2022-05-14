import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUser {
  late SharedPreferences _prefs;
  String? image;
  Future<bool> login() async {
    _prefs = await SharedPreferences.getInstance();

    return await _prefs.setBool('login', true);
  }

  Future<bool> isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('login') ?? false;
  }

  Future<bool> logout() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('login', false);
    return await _prefs.clear();
  }

  // Future<Map<String, dynamic>> saveUser(Map<String, dynamic> user) async {
  //   _prefs = await SharedPreferences.getInstance();

  //   await _prefs.setInt('stdId', user["stdId"] ?? 0);
  //   await _prefs.setInt('facultyNo', user["facultyNo"] ?? 0);
  //   await _prefs.setInt('facultyBatchId', user["facultyBatchId"] ?? 0);
  //   await _prefs.setInt('facultyProgramNo', user["facultyProgramNo"] ?? 0);
  //   await _prefs.setInt('facultyProgramSpecializationNo',
  //       user["facultyProgramSpecializationNo"] ?? 0);
  //   await _prefs.setInt('facultySemesterId', user["facultySemesterId"] ?? 0);
  //   await _prefs.setString('studentIndexNo', user["studentIndexNo"] ?? '');
  //   await _prefs.setString('firstName', user["firstName"] ?? '');
  //   await _prefs.setString('middleName', user["middleName"] ?? '');
  //   // await _prefs.setString('image', user["photoImage"] ?? '');

  //   return user;
  // }

  Future<int> saveId(int id) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('id', id);
    return id;
  }

  Future<int> getID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('id') ?? -1);
  }
}
