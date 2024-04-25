
enum MaskType {
  phone('phone', '(##) #####-####'),
  date('date', '##/##/####');

  const MaskType(this.name, this.value);
  final String name;
  final String value;
}