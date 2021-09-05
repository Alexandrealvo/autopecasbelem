class MapaEvento {
  String confdata;
  String idcliente;
  String fantasia;
  String endereco;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String ctlgps;
  String latlng;
  String idvisita;
  String checkin;
  String checkout;
  String ctlcheckout;
  String dtagenda;
  String infocheckin;
  String infocheckout;
  String obs;

  MapaEvento(
      {this.confdata,
      this.idcliente,
      this.fantasia,
      this.endereco,
      this.numero,
      this.complemento,
      this.bairro,
      this.cidade,
      this.uf,
      this.ctlgps,
      this.latlng,
      this.idvisita,
      this.checkin,
      this.checkout,
      this.ctlcheckout,
      this.dtagenda,
      this.infocheckin,
      this.infocheckout,
      this.obs});

  MapaEvento.fromJson(Map<String, dynamic> json) {
    confdata = json['confdata'];
    idcliente = json['idcliente'];
    fantasia = json['fantasia'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json[' cidade'];
    uf = json['uf'];
    ctlgps = json['ctlgps'];
    latlng = json['latlng'];
    idvisita = json['idvisita'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    ctlcheckout = json['ctlcheckout'];
    dtagenda = json['dtagenda'];
    infocheckin = json['infocheckin'];
    infocheckout = json['infocheckout'];
    obs = json['obs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['confdata'] = this.confdata;
    data['idcliente'] = this.idcliente;
    data['fantasia'] = this.fantasia;
    data['endereco'] = this.endereco;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['ctl_gps'] = this.ctlgps;
    data['latlng'] = this.latlng;
    data['idvisita'] = this.idvisita;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['ctlcheckout'] = this.ctlcheckout;
    data['dtagenda'] = this.dtagenda;
    data['infocheckin'] = this.infocheckin;
    data['infocheckout'] = this.infocheckout;
    obs = data['obs'] = this.obs;
    return data;
  }
}
