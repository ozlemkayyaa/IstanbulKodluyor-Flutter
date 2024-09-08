import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

// hiç bir event almadığı durumda, yani uygulmanın ilk açıldığı durum,
// burada başlangıç state'ine ihtiyaç duyar.

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;
  ArticleBloc({required this.articleRepository}) : super(ArticlesInitial()) {
    // on fonksiyonu Constructor'ın içine yazılır,
    // on fonksiyonunun generic kısmına hangi event fırladığında ne yapmak istediğini yazabilirsin.
    on<FetchArticles>(_onFetch);

    on<AddArticle>(_onAdd);
  }

  void _onFetch(FetchArticles event, Emitter<ArticleState> emit) async {
    // emit, state'i değiştirebilmeyi sağlayan bir fonksiyondur.
    emit(ArticlesLoading());
    final blogList = await articleRepository.fetchBlogs();
    emit(ArticlesLoaded(blogs: blogList));
  }

  void _onAdd(AddArticle event, Emitter<ArticleState> emit) async {
    final addArticle = await articleRepository.addBlog(
      event.selectedImage,
      event.title,
      event.content,
      event.author,
    );
    if (addArticle == true) {}
  }
}
