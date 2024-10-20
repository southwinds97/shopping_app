import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/auth/loginAuth.dart';
import 'package:shopping_app/auth/profilAuth.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/navigation.dart';
import 'package:shopping_app/screens/productDetail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopping_app/data/productDTO.dart'; // ProductDTO 클래스 임포트

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final _control = PageController();

class _HomeState extends State<Home> {
  List<ProductDTO> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://172.30.1.1:8586/api/'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> productJson = decodedResponse;
      setState(() {
        products =
            productJson.map((json) => ProductDTO.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Appbar(),
            // SearchBox(),
            bannerr(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductDetailScreen(
                              productId: product.productId!,
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
                              padding: const EdgeInsets.only(bottom: 110),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/productList/${product.imgId}',
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
                                product.productName != null &&
                                        product.productName!.length > 10
                                    ? '${product.productName!.substring(0, 10)}...'
                                    : product.productName ?? '',
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₩ ${product.price ?? ''}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: mains.withOpacity(0.7)),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: mains.withOpacity(0.7),
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart_outlined,
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
                  childCount: min(products.length, 50),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }

  SliverToBoxAdapter bannerr() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: PageView(
              controller: _control,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: banner_builder(0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: banner_builder(1),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: banner_builder(2),
                  ),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _control,
            count: 3,
            effect: WormEffect(
              dotWidth: 11,
              dotHeight: 11,
              activeDotColor: mains,
              dotColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Row banner_builder(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '새 상품 안내',
                style: TextStyle(
                  color: mains,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                products.isNotEmpty
                    ? (products[count].productName != null &&
                            products[count].productName!.length > 10
                        ? '${products[count].productName!.substring(0, 10)}...'
                        : products[count].productName ?? '')
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Text(
                products.isNotEmpty ? '₩ ${products[count].price ?? ''}' : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProductDetailScreen(
                        productId: products[count].productId!,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 90,
                  height: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mains,
                  ),
                  child: const Text(
                    '바로가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: products.isNotEmpty
              ? Image.asset(
                  'assets/images/productList/${products[count].imgId}',
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                )
              : Container(),
        ),
      ],
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 15),
                    Text('검색할 상품을 입력해주세요.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 194, 187, 187),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mains,
                ),
                child: const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 상단 ui(header)
  SliverToBoxAdapter Appbar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 상단 ui 메뉴
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Icon(Icons.list),
            ),
            const SizedBox(width: 10),
            // 상단 ui 타이틀
            Container(
              width: 240,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  'GUZIK TIGER',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // 상단 ui 로고
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const Navi(initialIndex: 3),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profil.jpg'),
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
