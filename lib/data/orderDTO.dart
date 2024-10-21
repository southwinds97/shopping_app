import 'package:flutter/material.dart';

class OrderDTO {
  final String orderId;
  final String memberId;
  final DateTime orderDate;
  final String orderName;
  final String orderPhone;
  final String orderAddr;
  final int orderAmount;
  final String payment;
  final String delivCharge;
  final String orderProg;
  final String delivProg;

  final String productId;
  final String productName;
  final String optionId;
  final int quantity;
  final String cartDtlId;
  final String imgId;
  final String optionYn;
  final List<String> optionList;
  final List<String> cartDtlIdList;

  final String subCate;
  final String productContent;
  final int stock;
  final int price;
  final DateTime regidate;
  final String optionCate;
  final int idx;
  final int sellCount;
  final String optionIdList;
  final String cdName;
  final int points;

  // 결제 금액 관련 필드
  final int applyPoint;
  final int delvAmout;
  final int productDscount;
  final int totalPaymentAmount;
  final int totalProductPrice;

  OrderDTO({
    required this.orderId,
    required this.memberId,
    required this.orderDate,
    required this.orderName,
    required this.orderPhone,
    required this.orderAddr,
    required this.orderAmount,
    required this.payment,
    required this.delivCharge,
    required this.orderProg,
    required this.delivProg,
    required this.productId,
    required this.productName,
    required this.optionId,
    required this.quantity,
    required this.cartDtlId,
    required this.imgId,
    required this.optionYn,
    required this.optionList,
    required this.cartDtlIdList,
    required this.subCate,
    required this.productContent,
    required this.stock,
    required this.price,
    required this.regidate,
    required this.optionCate,
    required this.idx,
    required this.sellCount,
    required this.optionIdList,
    required this.cdName,
    required this.points,
    required this.applyPoint,
    required this.delvAmout,
    required this.productDscount,
    required this.totalPaymentAmount,
    required this.totalProductPrice,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      orderId: json['order_id'],
      memberId: json['member_id'],
      orderDate: DateTime.parse(json['order_date']),
      orderName: json['order_name'],
      orderPhone: json['order_phone'],
      orderAddr: json['order_addr'],
      orderAmount: json['order_amount'],
      payment: json['payment'],
      delivCharge: json['deliv_charge'],
      orderProg: json['order_prog'],
      delivProg: json['deliv_prog'],
      productId: json['product_id'],
      productName: json['product_name'],
      optionId: json['option_id'],
      quantity: json['quantity'],
      cartDtlId: json['cart_dtl_id'],
      imgId: json['img_id'],
      optionYn: json['option_yn'],
      optionList: List<String>.from(json['option_list']),
      cartDtlIdList: List<String>.from(json['cart_dtl_id_list']),
      subCate: json['sub_cate'],
      productContent: json['product_content'],
      stock: json['stock'],
      price: json['price'],
      regidate: DateTime.parse(json['regidate']),
      optionCate: json['option_cate'],
      idx: json['idx'],
      sellCount: json['sell_count'],
      optionIdList: json['option_id_list'],
      cdName: json['cd_name'],
      points: json['points'],
      applyPoint: json['apply_point'],
      delvAmout: json['delv_amout'],
      productDscount: json['product_dscount'],
      totalPaymentAmount: json['total_payment_amount'],
      totalProductPrice: json['total_product_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'member_id': memberId,
      'order_date': orderDate.toIso8601String(),
      'order_name': orderName,
      'order_phone': orderPhone,
      'order_addr': orderAddr,
      'order_amount': orderAmount,
      'payment': payment,
      'deliv_charge': delivCharge,
      'order_prog': orderProg,
      'deliv_prog': delivProg,
      'product_id': productId,
      'product_name': productName,
      'option_id': optionId,
      'quantity': quantity,
      'cart_dtl_id': cartDtlId,
      'img_id': imgId,
      'option_yn': optionYn,
      'option_list': optionList,
      'cart_dtl_id_list': cartDtlIdList,
      'sub_cate': subCate,
      'product_content': productContent,
      'stock': stock,
      'price': price,
      'regidate': regidate.toIso8601String(),
      'option_cate': optionCate,
      'idx': idx,
      'sell_count': sellCount,
      'option_id_list': optionIdList,
      'cd_name': cdName,
      'points': points,
      'apply_point': applyPoint,
      'delv_amout': delvAmout,
      'product_dscount': productDscount,
      'total_payment_amount': totalPaymentAmount,
      'total_product_price': totalProductPrice,
    };
  }
}
