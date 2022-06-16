class UaePassVerify {
  UaePassVerify({
    required this.active,
  });
  late final bool active;
  
  UaePassVerify.fromJson(Map<String, dynamic> json){
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['active'] = active;
    return _data;
  }
}