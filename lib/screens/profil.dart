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
      MaterialPageRoute(builder: (context) => const Navi()), // 메인화면으로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage('assets/images/profil.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  memberName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  memberId,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mains,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('프로필 수정'),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Settings(),
                OrderList(),
                Inquiryhistory(),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Info(),
                LogOut(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile Settings() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mains,
          border: Border.all(color: mains, width: 2),
        ),
        child: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: const Text(
        '설정',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[200],
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }

  ListTile OrderList() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mains,
          border: Border.all(color: mains, width: 2),
        ),
        child: const Icon(
          Icons.credit_card,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: const Text(
        '주문 내역',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[200],
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }

  ListTile Inquiryhistory() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mains,
          border: Border.all(color: mains, width: 2),
        ),
        child: const Icon(
          Icons.assignment,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: const Text(
        '문의 내역',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[200],
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }

  ListTile Info() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mains,
          border: Border.all(color: mains, width: 2),
        ),
        child: const Icon(
          Icons.info,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: const Text(
        '나의 정보',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[200],
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }

  GestureDetector LogOut() {
    return GestureDetector(
      onTap: _logout,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: mains,
            border: Border.all(color: mains, width: 2),
          ),
          child: const Icon(
            Icons.logout,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          '로그아웃',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey[200],
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      ),
    );
  }
}
