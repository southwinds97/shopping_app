import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/data/memberDTO.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  MemberDTO? member;
  String memberId = '';

  @override
  void initState() {
    super.initState();
    loadMemberId();
  }

  Future<void> loadMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getString('memberId') ?? '';
    });
    fetchMemberInfo();
  }

  Future<void> fetchMemberInfo() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://ec2-54-206-169-132.ap-southeast-2.compute.amazonaws.com:8586/api/myInfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'member_id': memberId,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          member = MemberDTO.fromJson(decodedResponse);
        });
      } else {
        print('Failed to load member info: ${response.statusCode}');
        throw Exception('Failed to load member info');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load member info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('내 정보'),
        centerTitle: true,
      ),
      body: member == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.all(10),
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
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      buildInfoTile(Icons.person, member!.id),
                      buildInfoTile(Icons.face, member!.name),
                      buildInfoTile(Icons.email, member!.email),
                      buildInfoTile(Icons.phone, member!.tel),
                      buildInfoTile(
                          Icons.home,
                          (member!.addr ?? '') +
                              ' ' +
                              (member!.detailaddr ?? '')),
                      buildInfoTile(Icons.wc, member!.gen),
                      buildInfoTile(Icons.cake, member!.birth),
                      buildInfoTile(Icons.savings, member!.points.toString()),
                      buildInfoTile(
                          Icons.date_range, member!.regdate.toString()),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      // 버튼 두개 추가(가로로 나열)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
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
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('회원 탈퇴'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildInfoTile(IconData icon, String? value) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mains,
          border: Border.all(color: mains, width: 2),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        '$value',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
