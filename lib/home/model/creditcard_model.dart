
class CreditCardModel {
  String rowId="";
  String createdTime="";
  String modifiedTime="";
  String creatorId="";
  String idUser="";
  String number="";
  String cvv="";
  String nameUser="";
  String flag="";
  String dateExpire="";
  String status="";

  CreditCardModel(
    this.rowId,
    this.createdTime,
    this.modifiedTime,
    this.creatorId,
    this.idUser,
    this.number,
    this.cvv,
    this.nameUser,
    this.flag,
    this.dateExpire,
    this.status,
  );

  CreditCardModel.fromJson(Map<String, dynamic> json) {
    rowId = json['ROWID'];
    createdTime = json['CREATEDTIME'];
    modifiedTime = json['MODIFIEDTIME'];
    creatorId = json['CREATORID'];
    idUser = json['idUser'];
    number = json['number'];
    cvv = json['cvv'];
    nameUser = json['nameUser'];
    flag = json['flag'];
    dateExpire = json['dateExpire'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ROWID'] = this.rowId;
    data['CREATEDTIME'] = this.createdTime;
    data['MODIFIEDTIME'] = this.modifiedTime;
    data['CREATORID'] = this.creatorId;
    data['idUser'] = this.idUser;
    data['number'] = this.number;
    data['cvv'] = this.cvv;
    data['nameUser'] = this.nameUser;
    data['flag'] = this.flag;
    data['dateExpire'] = this.dateExpire;
    data['status'] = this.status;
    return data;
  }
}
