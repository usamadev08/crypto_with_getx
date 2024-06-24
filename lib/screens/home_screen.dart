import 'package:crypto_with_getx/controler/coin_controler.dart';
import 'package:crypto_with_getx/utils/text_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CoinController controller = Get.put(CoinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff494f55),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crypto Market',
                style: textStyle(25, Colors.white, FontWeight.bold),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              controller.errorMessage.value,
                              style: textStyle(18, Colors.red, FontWeight.w600),
                            ),
                          )
                        : controller.coinList.isEmpty
                            ? Center(
                                child: Text(
                                  'No data available',
                                  style: textStyle(
                                      18, Colors.white, FontWeight.w600),
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.coinList.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[700]!,
                                                          offset: Offset(4, 4),
                                                          blurRadius: 5),
                                                    ]),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Image.network(
                                                      controller.coinList[index]
                                                          .image),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    controller
                                                        .coinList[index].name,
                                                    style: textStyle(
                                                        18,
                                                        Colors.white,
                                                        FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${controller.coinList[index].priceChangePercentage24h} %',
                                                    style: textStyle(
                                                        18,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '€ ${controller.coinList[index].currentPrice}',
                                                style: textStyle(
                                                    18,
                                                    Colors.white,
                                                    FontWeight.w600),
                                              ),
                                              Text(
                                                controller
                                                    .coinList[index].symbol,
                                                style: textStyle(
                                                    18,
                                                    Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
