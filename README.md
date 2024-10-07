# 쇼핑몰 앱 제작 (Flutter)

이 문서는 Flutter를 이용하여 쇼핑몰 앱을 제작했습니다.

## 요구 사항

- Flutter SDK
- Dart 언어
- Android Studio 또는 Visual Studio Code
- sql

## 프로젝트 설정

1. Flutter SDK 설치
2. 새로운 Flutter 프로젝트 생성:
   ```bash
   flutter create shopping_app
   ```
3. 프로젝트 디렉토리로 이동:
   ```bash
   cd shopping_app
   ```

## 주요 기능

1. **사용자 인증**: API을 이용하여 사용자 로그인 및 회원가입 기능 구현.
2. **상품 목록**: API를 통해 상품 목록을 불러와서 화면에 표시.
3. **상품 상세**: API를 통해 상품 상세를 불러와서 화면에 표시
4. **장바구니**: 사용자가 선택한 상품을 장바구니에 추가하고, 장바구니 내용을 확인 및 수정.
5. **결제**: 결제 게이트웨이를 연동하여 결제 기능 구현.

## 디렉토리 구조

```
/lib


    /auth
         - auth.dart
    /constants
         - colors.dart
         - navigation.dart
    /screens
         - home.dart
         - product_detail_screen.dart
         - login_page.dart
    main.dart

```

## 시작하기

1. `main.dart` 파일을 열고 기본 앱 구조를 설정합니다.

## 참고 자료

- [Flutter-Shopping-App]:https://github.com/alireza4585/Flutter-Shopping-App


