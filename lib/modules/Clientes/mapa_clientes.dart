class Dadosclientes {
  String idcliente;
  String nomecliente;
  String endereco;
  String end;
  String numero;
  String bairro;
  String cidade;
  String uf;
  String cep;
  String tel;
  String cel;
  String whatsapp;
  String responsavel;
  String whatresp;
  String celresp;
  String niverresp;
  String status;
  String statuscliente;
  String observacao;
  String lat;
  String lng;
  String imgfachada;

  Dadosclientes(
      String idcliente,
      String nomecliente,
      String endereco,
      String end,
      String numero,
      String bairro,
      String cidade,
      String uf,
      String cep,
      String tel,
      String cel,
      String whatsapp,
      String responsavel,
      String whatresp,
      String celresp,
      String niverresp,
      String status,
      String statuscliente,
      String observacao,
      String lat,
      String lng,
      String imgfachada) {
    this.idcliente = idcliente;
    this.nomecliente = nomecliente;
    this.endereco = endereco;
    this.end = end;
    this.numero = numero;
    this.bairro = bairro;
    this.cidade = cidade;
    this.uf = uf;
    this.cep = cep;
    this.tel = tel;
    this.cel = cel;
    this.whatsapp = whatsapp;
    this.responsavel = responsavel;
    this.whatresp = whatresp;
    this.celresp = celresp;
    this.niverresp = niverresp;
    this.status = status;
    this.statuscliente = statuscliente;
    this.observacao = observacao;
    this.lat = lat;
    this.lng = lng;
    this.imgfachada = imgfachada;
  }

  Dadosclientes.fromJson(Map json) {
    idcliente = json['idcliente'];
    nomecliente = json['nomecliente'];
    endereco = json['endereco'];
    end = json['end'];
    numero = json['numero'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    cep = json['cep'];
    tel = json['tel'];
    cel = json['cel'];
    whatsapp = json['whatsapp'];
    responsavel = json['responsavel'];
    whatresp = json['whatresp'];
    celresp = json['celresp'];
    niverresp = json['niverresp'];
    status = json['status'];
    statuscliente = json['statuscliente'];
    observacao = json['observacao'];
    lat = json['lat'];
    lng = json['lng'];
    imgfachada = json['imgfachada'];
  }
}
