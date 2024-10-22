import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/screens/productDetail.dart';
import 'package:shopping_app/data/productDTO.dart'; // ProductDTO 클래스 임포트

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ProductDTO> categories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories('뚱랑이');
  }

  Future<void> fetchCategories(String keyword) async {
    try {
      final response = await http.post(
        Uri.parse('http://ec2-54-206-169-132.ap-southeast-2.compute.amazonaws.com:8586/api/category'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'keyword': keyword}),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> categoryJson = decodedResponse;
        setState(() {
          categories =
              categoryJson.map((json) => ProductDTO.fromJson(json)).toList();
        });
      } else {
        print('Failed to load categories: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '카테고리',
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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 카테고리 버튼 추가
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryButton(
                      label: '인형',
                      onTap: () => fetchCategories('인형'),
                    ),
                    CategoryButton(
                      label: '키링',
                      onTap: () => fetchCategories('키링'),
                    ),
                    CategoryButton(
                      label: '파우치',
                      onTap: () => fetchCategories('파우치'),
                    ),
                    CategoryButton(
                      label: '케이스',
                      onTap: () => fetchCategories('케이스'),
                    ),
                    CategoryButton(
                      label: '컵',
                      onTap: () => fetchCategories('컵'),
                    ),
                    CategoryButton(
                      label: '패드',
                      onTap: () => fetchCategories('패드'),
                    ),
                    CategoryButton(
                      label: '스티커',
                      onTap: () => fetchCategories('스티커'),
                    ),
                    CategoryButton(
                      label: '엽서',
                      onTap: () => fetchCategories('엽서'),
                    ),
                    // 필요한 만큼 카테고리 버튼 추가
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SearchBox(),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    sliver: categories.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Text('카테고리를 불러올 수 없습니다.'),
                            ),
                          )
                        : SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final category = categories[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductDetailScreen(
                                          productId: category.productId!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 110),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              'assets/images/productList/${category.imgId}',
                                              height: 200,
                                              width: 190,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 165,
                                          left: 10,
                                          child: Text(
                                            // 글자가 길면 ...으로 처리
                                            category.productName != null &&
                                                    category.productName!
                                                            .length >
                                                        10
                                                ? '${category.productName!.substring(0, 10)}...'
                                                : category.productName ?? '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Positioned(
                                          top: 210,
                                          left: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '₩ ${category.price ?? ''}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: mains
                                                          .withOpacity(0.7)),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    color:
                                                        mains.withOpacity(0.7),
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: min(categories.length, 50),
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 270,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 상단 ui(검색창)
  SliverToBoxAdapter SearchBox() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15),
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: '검색할 상품을 입력해주세요.',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  String keyword = _searchController.text.isEmpty
                      ? '뚱랑이'
                      : _searchController.text;
                  fetchCategories(keyword);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mains,
                  ),
                  child: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 카테고리 버튼 위젯
class CategoryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: mains),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
