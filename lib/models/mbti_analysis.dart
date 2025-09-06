class MBTIAnalysis {
  final String mbtiType;
  final String personalityType;
  final MBTIAnalyses analyses;
  final String similarCelebrity;

  MBTIAnalysis({
    required this.mbtiType,
    required this.personalityType,
    required this.analyses,
    required this.similarCelebrity,
  });

  factory MBTIAnalysis.fromJson(Map<String, dynamic> json) {
    return MBTIAnalysis(
      mbtiType: json['mbtiType'] ?? 'Unknown',
      personalityType: json['personalityType'] ?? 'Your Personality Type',
      analyses: MBTIAnalyses.fromJson(json['analyses'] ?? {}),
      similarCelebrity: json['similarCelebrity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mbtiType': mbtiType,
      'personalityType': personalityType,
      'analyses': analyses.toJson(),
      'similarCelebrity': similarCelebrity,
    };
  }
}

class MBTIAnalyses {
  final String ie;
  final String sn;
  final String tf;
  final String jp;

  MBTIAnalyses({
    required this.ie,
    required this.sn,
    required this.tf,
    required this.jp,
  });

  factory MBTIAnalyses.fromJson(Map<String, dynamic> json) {
    return MBTIAnalyses(
      ie: json['IE'] ?? '',
      sn: json['SN'] ?? '',
      tf: json['TF'] ?? '',
      jp: json['JP'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'IE': ie, 'SN': sn, 'TF': tf, 'JP': jp};
  }
}
