import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/data/wishListDTO.dart'; // WishListDTO 클래스 임포트
import 'package:shopping_app/screens/productDetail.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<WishListDTO> wishList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWishList();
  }

  Future<void> fetchWishList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? memberId = prefs.getString('memberId'); // memberId 읽기

      if (memberId == null) {
        throw Exception('memberId가 없습니다.');
      }

      print('memberId: $memberId'); // memberId 출력

      final response = await http.get(
        Uri.parse(
            'http://172.30.1.1:8586/api/wishList?id=$memberId'), // memberId를 URL 파라미터로 포함
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        print('Response: $decodedResponse'); // 응답 본문 출력

        // 응답 형식 확인
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('wishListData')) {
          List<dynamic> wishListJson = decodedResponse['wishListData'];
          print('wishListJson: $wishListJson'); // wishListJson 출력
          setState(() {
            wishList =
                wishListJson.map((json) => WishListDTO.fromJson(json)).toList();
            print('wishList: $wishList'); // wishList 출력
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print(
              'Unexpected response format: $decodedResponse'); // 예상치 못한 응답 형식 출력
          throw Exception('Unexpected response format');
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load wish list: ${response.statusCode}'); // 상태 코드 출력
        throw Exception('Failed to load wish list');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e'); // 예외 출력
      throw Exception('Failed to load wish list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '관심상품',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: mains,
        iconTheme: const IconThemeData(
          color: Colors.white, // 뒤로가기 버튼 색상 설정
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: wishList.length,
                itemBuilder: (context, index) {
                  final product = wishList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: product.productId!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: product.imgId != null &&
                                      product.imgId!.isNotEmpty
                                  ? Image.asset(
                                      'assets/images/productList/${product.imgId}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/productList/noimg.gif',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '₩ ${product.price ?? ''}원' ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: mains,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: mains),
                              onPressed: () {
                                setState(() {
                                  wishList.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
