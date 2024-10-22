import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/navigation.dart';
import 'package:shopping_app/data/productDTO.dart'; // ProductDTO 클래스 임포트
import 'package:shopping_app/screens/home.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDTO? product;
  bool isLoading = true;
  int index2 = 0;
  int index3 = 0;
  List<String> getImages = []; // 이미지 리스트 초기화
  List<String> option = []; // 옵션 리스트 초기화
  String img_id = 'default_img_id'; // img_id 변수 정의 및 초기화

  @override
  void initState() {
    super.initState();
    fetchProductDetail();
  }

  Future<void> fetchProductDetail() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://ec2-54-206-169-132.ap-southeast-2.compute.amazonaws.com:8586/api/productDetail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'product_id': widget.productId,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        print('Response: $decodedResponse'); // 응답 본문 출력

        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('productViewList')) {
          List<dynamic> productViewList = decodedResponse['productViewList'];
          if (productViewList.isNotEmpty) {
            setState(() {
              product = ProductDTO.fromJson(productViewList[0]);
              // 이미지 리스트와 옵션 리스트 초기화
              getImages = productViewList
                  .map((item) => item['img_id'] as String)
                  .toList();
              option = productViewList
                  .map((item) => item['option_id'] as String)
                  .toList();
              isLoading = false;
            });
          }
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
        print(
            'Failed to load product detail: ${response.statusCode}'); // 상태 코드 출력
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e'); // 예외 출력
      throw Exception('Failed to load product detail');
    }
  }

  Future<void> addToWishList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? memberId = prefs.getString('memberId'); // memberId 읽기

      if (memberId == null) {
        throw Exception('memberId가 없습니다.');
      }

      final response = await http.post(
        Uri.parse(
            'http://ec2-54-206-169-132.ap-southeast-2.compute.amazonaws.com:8586/api/wishListAdd'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'member_id': memberId,
          'product_id': widget.productId,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        print('Response: $decodedResponse'); // 응답 본문 출력
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('위시리스트에 추가되었습니다.')),
        );
      } else if (response.statusCode == 409) {
        final decodedResponse = json.decode(response.body);
        print('Response: $decodedResponse'); // 응답 본문 출력
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미 위시리스트에 추가되었습니다.')),
        );
      } else {
        print('Failed to add to wish list: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('위시리스트 추가에 실패했습니다.')),
        );
      }
    } catch (e) {
      print('Error: $e'); // 예외 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인이 필요합니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // getImages 리스트가 비어 있는 경우 기본 이미지를 추가
    if (getImages.isEmpty) {
      getImages.add('default_img_id'); // 기본 이미지 ID를 추가
    }

    // getImages 리스트의 길이가 4보다 작으면 나머지를 같은 이미지로 채움
    if (getImages.length < 4) {
      for (int i = getImages.length; i < 4; i++) {
        getImages.add(getImages[0]);
      }
    }
    // getImages 리스트의 길이를 4로 제한
    List<String> limitedImages = getImages.length > 4
        ? getImages.sublist(0, 4)
        : List<String>.from(getImages);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₩ ${product?.price ?? ''}',
              style: TextStyle(
                color: mains,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add to cart 기능 추가
              },
              child: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                  color: mains,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      '장바구니',
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
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/images/productList/${getImages.isNotEmpty ? getImages[index2] : 'noimg.gif'}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    expandedHeight: 400,
                    backgroundColor: backgroundColor,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(10),
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 7),
                            Container(
                              height: 4,
                              width: 100,
                              decoration: BoxDecoration(
                                color: mains,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    actions: [
                      GestureDetector(
                        onTap: addToWishList,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(250, 250, 250, 0.6),
                            radius: 18,
                            child: Icon(
                              Icons.favorite_border,
                              color: mains,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                    title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Home(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 0.6),
                        radius: 18,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            product?.productName ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '4.3',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                              itemCount: 4, // itemCount를 4로 설정
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 0 : 24),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index2 = index;
                                      });
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: index2 == index
                                              ? mains
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/productList/${getImages[0]}',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            '디자인',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              itemCount: option.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 11),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index2 = index;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.2,
                                          color: index3 == index
                                              ? mains
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          option[index],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '상세정보',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              product?.productName ?? '상세 정보가 없습니다.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
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

  @override
  void deactivate() {
    index2 = 0;
    index3 = 0;
    super.deactivate();
  }
}
