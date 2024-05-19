import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/CryptoModel/CryptoData.dart';
import 'package:crypto_app/helpers/decimalRounder.dart';
import 'package:crypto_app/network/response_model.dart';
import 'package:crypto_app/provider/crypto_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int defaultChoiceIndex = 0;
  late Timer _timer;

  final List<String> _choiceList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];

  @override
  void initState() {
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();

    _timer = Timer.periodic(
        const Duration(seconds: 20), (timer) => cryptoProvider.getTopMarketCapData());

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(12),
          height: 200,
          width: double.infinity,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 100,
                ),
                Text(
                  'News Here !',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Marquee(
            text: 'This is the place for application news!  ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  child: const Text(
                    'BUY',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  child: const Text('SELL', style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Wrap(
                spacing: 8,
                children: List.generate(
                  _choiceList.length,
                  (index) => ChoiceChip(
                    label: Text(_choiceList[index]),
                    selected: defaultChoiceIndex == index,
                    selectedColor: Colors.blue[400],
                    onSelected: (value) {
                      setState(
                        () {
                          defaultChoiceIndex =
                              value ? index : defaultChoiceIndex;

                          switch (index) {
                            case 0:
                              cryptoProvider.getTopMarketCapData();
                              break;
                            case 1:
                              cryptoProvider.getTopGainersData();
                              break;
                            case 2:
                              cryptoProvider.getTopLosersData();
                              break;
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Consumer<CryptoDataProvider>(
            builder: (ctx, cryptoData, child) {
              switch (cryptoData.state.status) {
                case Status.LOADING:
                  return SizedBox(
                    height: 80,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.white,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: SizedBox(
                                              width: 25,
                                              height: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: SizedBox(
                                      width: 70,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: SizedBox(
                                              width: 25,
                                              height: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })),
                  );

                case Status.COMPLETED:
                  List<CryptoData>? cryptoModel =
                      cryptoData.dataFuture.data?.cryptoCurrencyList;
                  return ListView.separated(
                      itemBuilder: (ctx, i) {
                        int number = i + 1;
                        var tokenId = cryptoModel![i].id;
                        MaterialColor filterColor =
                            DecimalRounder.setColorFilter(
                                cryptoModel[i].quotes?[0].percentChange24h);

                        var finalPrice = DecimalRounder.removePriceDecimals(
                            cryptoModel[i].quotes![0].price);

                        // percent change setup decimals and colors
                        var percentChange =
                            DecimalRounder.removePercentDecimals(
                                cryptoModel[i].quotes![0].percentChange24h);

                        Color percentColor =
                            DecimalRounder.setPercentChangesColor(
                                cryptoModel[i].quotes![0].percentChange24h);
                        Icon percentIcon = DecimalRounder.setPercentChangesIcon(
                            cryptoModel[i].quotes![0].percentChange24h);

                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.075,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  number.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 15),
                                child: CachedNetworkImage(
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    height: 32,
                                    width: 32,
                                    imageUrl:
                                        "https://s2.coinmarketcap.com/static/img/coins/128x128/$tokenId.png",
                                    placeholder: (context, url) =>
                                        const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error);
                                    }),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cryptoModel[i].name!,
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      cryptoModel[i].symbol!,
                                      style: textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        filterColor, BlendMode.srcATop),
                                    child: SvgPicture.network(
                                        "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$$finalPrice",
                                        style: textTheme.bodySmall,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          percentIcon,
                                          Text(
                                            "$percentChange%",
                                            style: GoogleFonts.ubuntu(
                                                color: percentColor,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (ctx, i) => const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                      itemCount: 10);
                case Status.ERROR:
                  return Text(cryptoData.state.message);

                default:
                  return Container();
              }
            },
          ),
        )
      ],
    ));
  }
}
