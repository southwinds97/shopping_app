import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/data/product.dart'; // ProductDTO 클래스 임포트
import 'package:intl/intl.dart'; // intl 패키지 임포트

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<ProductDTO> cartProducts = [
    // 예제 데이터
    ProductDTO(
      productName: '무직타이거-쫀득쫀득-모찌-인형-6종',
      price: '50730',
      imgId: 'ee09f29c28ed0b7c25e8ca8754ad265c.jpg',
      productContent: '무직타이거 상품',
      quantity: 1,
    ),
    ProductDTO(
      productName: '뚱랑박스-폰케이스-3종',
      price: '25000',
      imgId: '83dafa38e87b0ac6581661fbf3c9eeb1.jpg',
      productContent: '무직타이거 상품',
      quantity: 1,
    ),
  ];

  final NumberFormat currencyFormat = NumberFormat('#,##0', 'ko_KR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '장바구니',
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
                            '\₩ ${currencyFormat.format(int.parse(product.price ?? '0'))}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: mains.withOpacity(0.7),
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
                          SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: mains),
                                onPressed: () {
                                  setState(() {
                                    if (product.quantity! > 1) {
                                      product.quantity = product.quantity! - 1;
                                    }
                                  });
                                },
                              ),
                              Text(
                                '${product.quantity}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: mains),
                                onPressed: () {
                                  setState(() {
                                    product.quantity = product.quantity! + 1;
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '합계: \₩ ${currencyFormat.format(cartProducts.fold<int>(0, (sum, item) => sum + int.parse(item.price ?? '0') * (item.quantity ?? 1)))}',
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
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                  color: mains,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.white,
                    ),
                    Text(
                      '결제',
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
