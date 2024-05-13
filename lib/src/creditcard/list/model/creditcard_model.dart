import '../../form/model/creditcard_form_model.dart';

class CreditCardModel {
  String rowId = "";
  String createdTime = "";
  String modifiedTime = "";
  String creatorId = "";
  String idUser = "";
  String number = "";
  String cvv = "";
  String nameUser = "";
  String flag = "";
  String dateExpire = "";
  String status = "";
  bool isOpen = false;

  CreditCardModel({
    required this.rowId,
    required this.createdTime,
    required this.modifiedTime,
    required this.creatorId,
    required this.idUser,
    required this.number,
    required this.cvv,
    required this.nameUser,
    required this.flag,
    required this.dateExpire,
    required this.status,
  });

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

  CreditCardModel toModel(CreditCardFormModel model) {
    return CreditCardModel(
        rowId: model.rowId,
        createdTime: model.createdTime,
        modifiedTime: model.modifiedTime,
        creatorId: model.creatorId,
        idUser: model.idUser,
        number: model.number,
        cvv: model.cvv,
        nameUser: model.nameUser,
        flag: model.flag,
        dateExpire: model.dateExpire,
        status: model.status);
  }

  static initObject() {
    return CreditCardModel(
      rowId: "",
      creatorId: "",
      createdTime: "",
      modifiedTime: "",
      idUser: "",
      nameUser: "",
      number: "",
      dateExpire: "",
      cvv: "",
      flag: "",
      status: "",
    );
  }
}
