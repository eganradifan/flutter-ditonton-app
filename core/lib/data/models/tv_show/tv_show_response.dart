import './tv_show_model.dart';
import 'package:equatable/equatable.dart';

class TvShowResponse extends Equatable {
  TvShowResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<TvShowModel> results;
  final int totalPages;
  final int totalResults;

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        page: json["page"],
        results: List<TvShowModel>.from(
            json["results"].map((x) => TvShowModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
