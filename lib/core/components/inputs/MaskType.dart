
enum MaskType {
  phone('phone', '(##) #####-####'),
  date('date', '##/##/####'),
  creditCard('creditCard', '#### #### #### ####'),
  dateCreditCard('dateCreditCard', '##/####');

  const MaskType(this.name, this.value);
  final String name;
  final String value;
}