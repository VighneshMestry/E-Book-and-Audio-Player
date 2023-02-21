import 'dart:convert';

import 'package:audio_player/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List popularBooks;
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then(
      (s) {
        setState(
          () {
            popularBooks = json.decode(s);
          },
        );
      },
    );
    await DefaultAssetBundle.of(context).loadString("json/books.json").then(
      (s) {
        setState(
          () {
            books = json.decode(s);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(       // In positioned at least one vertical parameter and atleast two horizontal parameter are required
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        // PageView runs in loops
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: popularBooks.length,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(popularBooks[i]["img"]),
                                      fit: BoxFit.fill),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    )
                                  ]),
                              tabs: const [
                                AppTab(
                                    color: AppColors.menu1Color, text: "New"),
                                AppTab(
                                    color: AppColors.menu2Color,
                                    text: "Popular"),
                                AppTab(
                                    color: AppColors.menu3Color,
                                    text: "Trending"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabBarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: const Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(books[i]["img"]),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 24,
                                              color: AppColors.starColor,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              books[i]["ratings"],
                                              style: const TextStyle(
                                                  color: AppColors.menu1Color),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          books[i]["title"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(books[i]["text"],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              color: AppColors.subTitleText,
                                            )),
                                        Container(
                                          width: 60,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.loveColor),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Love",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Avenir",
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
