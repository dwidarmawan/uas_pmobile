import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:membuat_berita/blocs/newsbloc/news.events.dart';
import 'package:membuat_berita/blocs/newsbloc/news_states.dart';
import 'package:membuat_berita/models/article_model.dart';
import 'package:membuat_berita/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepositoriy newsRepositotiy;
  NewsBloc({required NewsStates initialState, required this.newsRepositotiy})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewsLoadingState();
        _articleList = await newsRepositotiy.fetchNews();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e);
      }
    }
  }
}
