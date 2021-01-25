class MoviesByYearResponse {
  List<MoviesByYear> moviesByYear;
  int total;

  MoviesByYearResponse({this.moviesByYear, this.total});

  MoviesByYearResponse.fromJson(Map<String, dynamic> json) {
    if (json['moviesByYear'] != null) {
      moviesByYear = new List<MoviesByYear>();
      json['moviesByYear'].forEach((v) {
        moviesByYear.add(new MoviesByYear.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moviesByYear != null) {
      data['moviesByYear'] = this.moviesByYear.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class MoviesByYear {
  int year;
  int movies;

  MoviesByYear({this.year, this.movies});

  MoviesByYear.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    movies = json['movies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['movies'] = this.movies;
    return data;
  }
}
