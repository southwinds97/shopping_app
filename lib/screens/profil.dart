import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/navigation.dart';

class ProFil extends StatefulWidget {
  // final VoidCallback show;
  const ProFil({super.key});

  @override
  State<ProFil> createState() => _ProFilState();
}

class _ProFilState extends State<ProFil> {
  String memberId = '';
  String memberName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getString('memberId') ?? '';
      memberName = prefs.getString('memberName') ?? '';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 모든 저장된 데이터 초기화

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Navi()), // 메인화면으로 이동
    );
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
            info(),
            SizedBox(height: 15),
            LogOut(),
            SizedBox(height: 10),
            or(),
            SizedBox(height: 10),
            SignEdit(),
            SizedBox(height: 10),
            SignDelete(),
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

  Padding LogOut() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: _logout,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: mains,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "로그아웃",
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

  Padding SignEdit() {
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
          "회원 정보 수정",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding SignDelete() {
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
          "회원 탈퇴",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding info() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
              top: BorderSide(color: mains, width: 2),
              bottom: BorderSide(color: mains, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // 내부 여백 추가
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$memberName 님 환영합니다!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '저희 쇼핑몰을 찾아주셔서 감사합니다.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '뚱랑이와 그 친구들의 이야기를 들으러 오세요!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
