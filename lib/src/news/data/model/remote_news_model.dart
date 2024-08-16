import '../../news.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.sourceId,
    required super.sourceName,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceId: json["source"]["id"] ?? "",
      sourceName: json["source"]["name"] ?? "",
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] ?? "",
      content: json["content"] ?? "",
    );
  }

  factory ArticleModel.fromDatabase(Map<String, dynamic> json) {
    return ArticleModel(
      sourceId: json["sourceId"] ?? "",
      sourceName: json["sourceName"] ?? "",
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] ?? "",
      content: json["content"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "sourceId": sourceId,
        "sourceName": sourceName,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };

  Article toDomain() {
    return Article(
      sourceId: sourceId,
      sourceName: sourceName,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }

  factory ArticleModel.fromDomain(Article article) {
    return ArticleModel(
      sourceId: article.sourceId,
      sourceName: article.sourceName,
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }
}
