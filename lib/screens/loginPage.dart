import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/navigation.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback show;
  const LoginPage({super.key, required this.show});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final id = TextEditingController();
  final password = TextEditingController();
  bool vissible = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.33:8586/api/login'), // Spring Boot 서버 URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.text,
        'pass': password.text,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      // 로그인 성공 처리
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // 로그인 정보 저장
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('memberId', id.text);
      await prefs.setString('memberName', decodedResponse['name']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navi()),
      );
    } else {
      // 로그인 실패 처리
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('ID 또는 비밀번호가 잘못되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            logo(),
            const SizedBox(height: 34),
            textfield(),
            const SizedBox(height: 15),
            textfield2(),
            const SizedBox(height: 8),
            have(),
            const SizedBox(height: 20),
            signIN(),
            const SizedBox(height: 15),
            or(),
            const SizedBox(height: 15),
            WithKakao(),
            const SizedBox(height: 15),
            WithNaver(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Row or() {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          thickness: 1.5,
          endIndent: 4,
          indent: 20,
        )),
        Text(
          "OR",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const Expanded(
            child: Divider(
          thickness: 1.5,
          endIndent: 20,
          indent: 4,
        )),
      ],
    );
  }

  Padding signIN() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: loginUser, // 로그인 버튼 클릭 시 loginUser 함수 호출
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: mains,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "로그인",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Padding WithKakao() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(254, 229, 0, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/kakao.png',
                height: 30,
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "카카오 1초 로그인",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            trailing: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(
                Icons.arrow_right,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  Padding WithNaver() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(30, 200, 0, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/naver.png',
                height: 30,
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "네이버 1초 로그인",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            trailing: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  Padding have() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "계정이 없으신가요?",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "회원가입",
              style: TextStyle(
                color: mains,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding textfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: id,
          focusNode: _focusNode1,
          decoration: InputDecoration(
              hintText: 'ID',
              prefixIcon: Icon(
                Icons.person,
                color: _focusNode1.hasFocus ? mains : Colors.grey[600],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: mains,
                  width: 2,
                ),
              )),
        ),
      ),
    );
  }

  Padding textfield2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: password,
          focusNode: _focusNode2,
          obscureText: vissible,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      vissible = vissible;
                    });
                  },
                  child: Icon(
                    vissible ? Icons.visibility_off : Icons.visibility,
                    color: _focusNode2.hasFocus ? mains : Colors.grey[600],
                  )),
              hintText: 'Password',
              prefixIcon: Icon(
                Icons.key,
                color: _focusNode2.hasFocus ? mains : Colors.grey[600],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: mains,
                  width: 2,
                ),
              )),
        ),
      ),
    );
  }

  Padding logo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Image.asset('assets/images/guzikTiger.jpg'),
    );
  }
}
