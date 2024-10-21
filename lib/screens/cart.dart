import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/data/productDTO.dart'; // ProductDTO 클래스 임포트
import 'package:intl/intl.dart'; // intl 패키지 임포트

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String memberId = '';
  List<ProductDTO> cartProducts = [];
  List<int> selectedProductIndices = []; // 선택된 제품의 인덱스를 추적할 변수
  bool isLoading = true;

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
    fetchCartList();
  }

  Future<void> fetchCartList() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.33:8586/api/cartList'),
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
          cartProducts = (decodedResponse as List)
              .map((item) => ProductDTO.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        print('Failed to load cart list: ${response.statusCode}');
        throw Exception('Failed to load cart list');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  final NumberFormat currencyFormat = NumberFormat('#,##0', 'ko_KR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '장바구니',
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
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  final int price = int.tryParse(product.price ?? '0') ?? 0;
                  final int quantity = product.quantity ?? 1;
                  final bool isSelected =
                      selectedProductIndices.contains(index); // 선택된 제품인지 확인

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedProductIndices.remove(index);
                        } else {
                          selectedProductIndices.add(index);
                        }
                      });
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? mains
                                : Colors.transparent, // 선택된 제품의 테두리 강조
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            'assets/images/productList/${product.imgId ?? 'default_image.png'}',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.productName ?? '상품명 없음',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '₩ ${currencyFormat.format(price)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: mains.withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '[옵션: 0${product.idx}. ${product.optionId}]' ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove,
                                                  color: mains),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity > 1) {
                                                    product.quantity =
                                                        quantity - 1;
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              '$quantity',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon:
                                                  Icon(Icons.add, color: mains),
                                              onPressed: () {
                                                setState(() {
                                                  product.quantity =
                                                      quantity + 1;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: mains),
                                    onPressed: () {
                                      setState(() {
                                        cartProducts.removeAt(index);
                                        selectedProductIndices
                                            .remove(index); // 선택된 제품 목록에서도 제거
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Transform.scale(
                                scale: 0.8, // 체크박스 크기를 줄이기 위해 스케일 조정
                                child: Checkbox(
                                  value: isSelected,
                                  checkColor: mains,
                                  activeColor: Colors.white,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedProductIndices.add(index);
                                      } else {
                                        selectedProductIndices.remove(index);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '합계: ₩ ${currencyFormat.format(selectedProductIndices.fold<int>(0, (sum, index) {
                final product = cartProducts[index];
                final int price = int.tryParse(product.price ?? '0') ?? 0;
                final int quantity = product.quantity ?? 1;
                return sum + (price * quantity);
              }))}',
              style: TextStyle(
                color: mains,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // 결제 기능 추가
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: mains,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.white,
                    ),
                    Text(
                      '주문하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
