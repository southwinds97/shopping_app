import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class Signup extends StatefulWidget {
  final VoidCallback show;
  const Signup({Key? key, required this.show}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FocusNode _idNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  final id = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  bool vissible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _idNode.addListener(() {
      setState(() {});
    });
    _passwordNode.addListener(() {
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
    _idNode.dispose();
    _passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            logo(),
            SizedBox(height: 0),
            textfield(),
            SizedBox(height: 15),
            textfield2(),
            SizedBox(height: 15),
            textfield3(),
            SizedBox(height: 10),
            signIN(),
            SizedBox(height: 10),
            or(),
            SizedBox(height: 10),
            Cancel(),
            SizedBox(height: 10),
            have(),
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

  Padding Cancel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: widget.show,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "취소",
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

  Padding have() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "계정이 있으신가요?",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "로그인",
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
          focusNode: _idNode,
          decoration: InputDecoration(
              hintText: 'ID',
              prefixIcon: Icon(
                Icons.person,
                color: _idNode.hasFocus ? mains : Colors.grey[600],
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
          focusNode: _passwordNode,
          obscureText: vissible,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(
                Icons.key,
                color: _passwordNode.hasFocus ? mains : Colors.grey[600],
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
                    color: _focusNode3.hasFocus ? mains : Colors.grey[600],
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
