import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class I004 extends StatelessWidget {
  const I004({super.key});
  @override
  Widget build(BuildContext context) {
    double screeWidth = MediaQuery.of(context).size.width;
    logger.e(screeWidth);
    // double screeHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // width: 400,
            // height: 1350,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFF2F6F7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 64,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 295.17,
                        top: 8,
                        child: SizedBox(width: 48.85, height: 48),
                      ),
                      Positioned(
                        left: 19,
                        top: 17,
                        child: Container(
                          width: 30,
                          height: 30.52,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/30x31"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1223,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 218,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: const ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/70x70"),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const SizedBox(
                                    width: 149,
                                    height: 61,
                                    child: Text(
                                      '최지찬 강사',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 103,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 75,
                                          height: 28,
                                          child: Text(
                                            '쿠폰함',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF141212),
                                              fontSize: 15,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: 75,
                                          height: 28,
                                          child: Text(
                                            '리뷰 내역',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF141212),
                                              fontSize: 15,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: 75,
                                          height: 28,
                                          child: Text(
                                            '강습 내역',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF141212),
                                              fontSize: 15,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: 360,
                        height: 600,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 40,
                              top: 0,
                              child: Container(
                                width: 100,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '12/5(월)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 0,
                              child: Container(
                                width: 100,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '12/6(화)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 0,
                              child: Container(
                                width: 100,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20)),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '12/7(수)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 60,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 60,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 60,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 120,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 120,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 120,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 180,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 180,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 180,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 240,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 240,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 240,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 300,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 300,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 300,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 360,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 360,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 360,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 420,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 420,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 420,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 480,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 480,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 480,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 540,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              top: 540,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 240,
                              top: 540,
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFD6D6D6)),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 40,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 55),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '8시',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    Text(
                                      '9시',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    Text(
                                      '10시',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '11시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '12시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '13시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '14시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '15시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 41.50),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '16시',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 139.50,
                              top: 360,
                              child: Container(
                                width: 100,
                                height: 180,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFE4E4E4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFCDCBCB),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: Text(
                                        '1:3 스키\n장승호',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 150,
                              child: Container(
                                width: 100,
                                height: 120,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFE4E4E4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFCDCBCB),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: Text(
                                        '1:2 스키\n송준석',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 239.50,
                              top: 180,
                              child: Container(
                                width: 100,
                                height: 120,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFE4E4E4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFCDCBCB),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: Text(
                                        '1:1 스키\n최민호',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 239.50,
                              top: 390,
                              child: Container(
                                width: 100,
                                height: 120,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFE4E4E4),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFCDCBCB),
                                    ),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '1:1 개발\n고독한 늑대\n최민호',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
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
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.699999988079071),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 85,
                              height: 85,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/85x85"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'OOO의 스키 교실 1',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '팀정보를 간략하게 표시하면 좋을것 같습니다',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
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
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.699999988079071),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 85,
                              height: 85,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/85x85"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'OOO의 스키 교실 2',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '팀정보를 간략하게 표시하면 좋을것 같습니다',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
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
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.699999988079071),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 85,
                              height: 85,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/85x85"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'OOO의 스키 교실 3',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '팀정보를 간략하게 표시하면 좋을것 같습니다',
                                        style: TextStyle(
                                          color: Color(0xFF141212),
                                          fontSize: 15,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
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
                    ],
                  ),
                ),
                const Positioned(
                  left: 318.58,
                  top: 489.45,
                  child: SizedBox(
                    width: 12.07,
                    height: 12.99,
                    child: Stack(children: []),
                  ),
                ),
                const Positioned(
                  left: 318.58,
                  top: 699.94,
                  child: SizedBox(
                    width: 12.07,
                    height: 12.99,
                    child: Stack(children: []),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
