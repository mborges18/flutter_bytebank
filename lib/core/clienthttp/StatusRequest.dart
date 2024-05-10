
abstract class StatusRequest {}
class Success extends StatusRequest {
  Object object;
  Success(this.object);
}
class Error extends StatusRequest {
  Object object;
  Error(this.object);
}
class Exists extends StatusRequest {}
class Unauthorized extends StatusRequest {
  Object object;
  Unauthorized(this.object);
}
class Empty extends StatusRequest {}