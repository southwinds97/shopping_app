class MemberDTO {
  String? id;
  String? name;
  String? pass;
  String? hint;
  String? hintas;
  String? tel;
  String? email;
  int? postcode;
  String? addr;
  String? detailaddr;
  String? gen;
  String? birth;
  String? calendar;
  int? points;
  DateTime? regdate;
  int? userLevel;

  MemberDTO({
    this.id,
    this.name,
    this.pass,
    this.hint,
    this.hintas,
    this.tel,
    this.email,
    this.postcode,
    this.addr,
    this.detailaddr,
    this.gen,
    this.birth,
    this.calendar,
    this.points,
    this.regdate,
    this.userLevel,
  });

  factory MemberDTO.fromJson(Map<String, dynamic> json) {
    return MemberDTO(
      id: json['id'],
      name: json['name'],
      pass: json['pass'],
      hint: json['hint'],
      hintas: json['hintas'],
      tel: json['tel'],
      email: json['email'],
      postcode: json['postcode'],
      addr: json['addr'],
      detailaddr: json['detailaddr'],
      gen: json['gen'],
      birth: json['birth'],
      calendar: json['calendar'],
      points: json['points'],
      regdate: DateTime.tryParse(json['regdate'] ?? ''),
      userLevel: json['user_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pass': pass,
      'hint': hint,
      'hintas': hintas,
      'tel': tel,
      'email': email,
      'postcode': postcode,
      'addr': addr,
      'detailaddr': detailaddr,
      'gen': gen,
      'birth': birth,
      'calendar': calendar,
      'points': points,
      'regdate': regdate?.toIso8601String(),
      'user_level': userLevel,
    };
  }
}
