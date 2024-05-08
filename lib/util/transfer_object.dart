
abstract class TransferObject {}

class FilledData extends TransferObject {
  Object object;
  FilledData(this.object);
}

class EmptyData extends TransferObject {}