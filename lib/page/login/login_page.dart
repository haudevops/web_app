import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_app/utils/prefs_util.dart';
import 'package:web_app/utils/screen_util.dart';

import '../../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _userNameKey = GlobalKey<FormState>();
  final _userPasswordKey = GlobalKey<FormState>();

  final _userNameFocus = FocusNode();
  final _userPasswordFocus = FocusNode();

  String _token = '';
  String _password = '';

  void hiddenKeyBoard() {
    Future.delayed(const Duration(),
            () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Supra'.toUpperCase(),
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
          Container(
            margin: const EdgeInsets.only(right: 350, left: 350),
            child: Form(
              key: _userNameKey,
              child: TextFormField(
                focusNode: _userNameFocus,
                autofocus: true,
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Nhập tài khoản',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 2, color: Colors.pinkAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (_userNameKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(_userPasswordFocus);
                  } else {
                    FocusScope.of(context).requestFocus(_userNameFocus);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Nhập tài khoản';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
          Container(
            margin: const EdgeInsets.only(right: 350, left: 350),
            child: Form(
              key: _userPasswordKey,
              child: TextFormField(
                focusNode: _userPasswordFocus,
                autofocus: false,
                controller: _userPasswordController,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 2, color: Colors.pinkAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Sai mật khẩu';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
          Center(
            child: SizedBox(
              width: ScreenUtil.getInstance().getAdapterSize(100),
              child: ElevatedButton(
                  onPressed: () {
                    if (_userNameKey.currentState!.validate() &&
                        _userPasswordKey.currentState!.validate()) {
                      _token =
                          _userNameController.text + _userPasswordController.text;
                      _password = _userPasswordController.text;
                      if (kDebugMode) {
                        print('Token: $_token');
                      }
                      PrefsUtil.putString(Constants.LOGIN_TOKEN, _token);
                      PrefsUtil.putString(Constants.LOGIN_PASSWORD, _password);
                      // Navigator.pushNamed(context, NavigationPage.routeName)
                      //     .then((value) {
                      //   _userPasswordController.clear();
                      //   FocusScope.of(context).requestFocus(_userPasswordFocus);
                      // });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 1,
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(10),
                    ),
                  )),
            ),
          ),
          SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bạn chưa có tài khoản? ',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(10),
                  color: Colors.black45,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(10),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
