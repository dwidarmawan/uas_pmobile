import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:membuat_berita/blocs/newsbloc/news_bloc.dart';
import 'package:membuat_berita/blocs/newsbloc/news_states.dart';
import 'package:membuat_berita/models/article_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.03),
                  child: Text(
                    "News".toUpperCase(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.7),
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: height * 0.1),
            child: BlocBuilder<NewsBloc, NewsStates>(
                builder: (BuildContext context, NewsStates state) {
              if (state is NewsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsLoadedState) {
                List<ArticleModel> _articleList = [];
                _articleList = state.articleList;
                return ListView.builder(
                    itemCount: _articleList.length,
                    itemBuilder: (context, index) {
                      ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey,
                              height: height * 0.30,
                              margin: EdgeInsets.only(bottom: height * 0.02),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.3,
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "https://static01.nyt.com/images/2022/01/17/multimedia/17nba-pelicans/17nba-pelicans-jumbo.jpg?quality=75&auto=webp",
                                            ),
                                            fit: BoxFit.cover)),
                                  )
                                ],
                              ),
                            );
                          });

                      return Container(
                        color: Colors.grey,
                        height: height * 0.30,
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              height: height * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://static01.nyt.com/images/2022/01/17/multimedia/17nba-pelicans/17nba-pelicans-jumbo.jpg?quality=75&auto=webp",
                                      ),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      );
                    });
              } else if (state is NewsErrorState) {
                String error = state.errorMessage;

                return Center(child: Text(error));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      )),
    );
  }
}
