import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class Signup extends StatefulWidget {
  final VoidCallback show;
  const Signup({super.key, required this.show});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  final id = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  bool vissible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            logo(),
            SizedBox(height: 0),
            textfield(),
            SizedBox(height: 15),
            textfield2(),
            SizedBox(height: 15),
            textfield3(),
            SizedBox(height: 8),
            have(),
            SizedBox(height: 10),
            signIN(),
            SizedBox(height: 10),
            or(),
            SizedBox(height: 10),
            WithKakao(),
            SizedBox(height: 10),
            WithNaver(),
          ],
        ),
      ),
    );
  }

  Row or() {
    return Row(
      children: [
        Expanded(
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
        Expanded(
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
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: mains,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "회원가입",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
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
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          SizedBox(width: 10),
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
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
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
              hintText: 'Password',
              prefixIcon: Icon(
                Icons.key,
                color: _focusNode2.hasFocus ? mains : Colors.grey[600],
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
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

  Padding textfield3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: passwordConfirm,
          focusNode: _focusNode3,
          obscureText: vissible,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      vissible = !vissible;
                    });
                  },
                  child: Icon(
                    vissible ? Icons.visibility_off : Icons.visibility,
                    color: _focusNode2.hasFocus ? mains : Colors.grey[600],
                  )),
              hintText: 'Password Confirm',
              prefixIcon: Icon(
                Icons.key,
                color: _focusNode3.hasFocus ? mains : Colors.grey[600],
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
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
