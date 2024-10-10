import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/data/product.dart'; // ProductDTO 클래스 임포트

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<ProductDTO> cartProducts = [
    // 예제 데이터
    ProductDTO(
      productName: '뚱랑이의-하루-랜덤-피규어',
      imgId: 'shop1_d81f41f535d80e6e019b6c1237290019.jpg',
      productContent: '무직타이거 상품',
    ),
    ProductDTO(
      productName: '무직타이거-뚱랑이-테니스공-키링',
      imgId: '9ddad377f3339aa872374c0f2e981fbf.jpg',
      productContent: '무직타이거 상품',
    ),
    ProductDTO(
      productName: '자이언트-뚱랑이-쿠션-3종',
      imgId: 'shop1_5817327f8fc73658b5f755ade0117e5e.jpg',
      productContent: '무직타이거 상품',
    ),
    ProductDTO(
      productName: '뚱랑이-폰스트랩',
      imgId: 'shop1_83f8abcd5a908f2072c34557b277c96b.jpg',
      productContent: '무직타이거 상품',
    ),
    ProductDTO(
      productName: '파티-타이거-에어팟프로-케이스',
      imgId: 'shop1_a7df4da3ebc7a2386e78055a43959e56.jpg',
      productContent: '무직타이거 상품',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '관심상품',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: mains,
        iconTheme: IconThemeData(
          color: Colors.white, // 뒤로가기 버튼 색상 설정
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            final product = cartProducts[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/productList/${product.imgId}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.productContent ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: mains),
                      onPressed: () {
                        setState(() {
                          cartProducts.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
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
    );
  }
}
