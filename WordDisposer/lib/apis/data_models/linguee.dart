class Linguee {
  String srcLang;
  String dstLang;
  String query;
  String correctQuery;
  List<Matches> exactMatches;
  List<Matches> inexactMatches;
  List<RealExamples> realExamples;

  Linguee(
      {this.srcLang,
      this.dstLang,
      this.query,
      this.correctQuery,
      this.exactMatches,
      this.inexactMatches,
      this.realExamples});

  Linguee.fromJson(Map<String, dynamic> json) {
    srcLang = json['src_lang'];
    dstLang = json['dst_lang'];
    query = json['query'];
    correctQuery = json['correct_query'];
    if (json['exact_matches'] != null) {
      exactMatches = new List<Matches>();
      json['exact_matches'].forEach((v) {
        exactMatches.add(new Matches.fromJson(v));
      });
    }
    if (json['inexact_matches'] != null) {
      inexactMatches = new List<Matches>();
      json['inexact_matches'].forEach((v) {
        inexactMatches.add(new Matches.fromJson(v));
      });
    }
    if (json['real_examples'] != null) {
      realExamples = new List<RealExamples>();
      json['real_examples'].forEach((v) {
        realExamples.add(new RealExamples.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src_lang'] = this.srcLang;
    data['dst_lang'] = this.dstLang;
    data['query'] = this.query;
    data['correct_query'] = this.correctQuery;
    if (this.exactMatches != null) {
      data['exact_matches'] = this.exactMatches.map((v) => v.toJson()).toList();
    }
    if (this.inexactMatches != null) {
      data['inexact_matches'] =
          this.inexactMatches.map((v) => v.toJson()).toList();
    }
    if (this.realExamples != null) {
      data['real_examples'] = this.realExamples.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  bool featured;
  String text;
  List<Translations> translations;

  Matches({this.featured, this.text, this.translations});

  Matches.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    text = json['text'];

    if (json['translations'] != null) {
      translations = new List<Translations>();
      json['translations'].forEach((v) {
        translations.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featured'] = this.featured;
    data['text'] = this.text;

    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  bool featured;
  String text;
  List<Examples> examples;

  Translations({this.featured, this.text, this.examples});

  Translations.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    text = json['text'];

    if (json['examples'] != null) {
      examples = new List<Examples>();
      json['examples'].forEach((v) {
        examples.add(new Examples.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featured'] = this.featured;
    data['text'] = this.text;

    if (this.examples != null) {
      data['examples'] = this.examples.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Examples {
  String source;
  String target;

  Examples({this.source, this.target});

  Examples.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['target'] = this.target;
    return data;
  }
}

class RealExamples {
  String src;
  String dst;

  RealExamples({this.src, this.dst});

  RealExamples.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    dst = json['dst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['dst'] = this.dst;
    return data;
  }
}
