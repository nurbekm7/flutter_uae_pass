class UserProfile {
  UserProfile({
    required this.fullname,
    required this.eid,
    required this.accesscode,
  });
  late final String fullname;
  late final String eid;
  late final String accesscode;
  
  UserProfile.fromJson(Map<String, dynamic> json){
    fullname = json['fullname'];
    eid = json['eid'];
    accesscode = json['accesscode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullname'] = fullname;
    _data['eid'] = eid;
    _data['accesscode'] = accesscode;
    return _data;
  }
}