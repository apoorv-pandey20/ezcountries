// Base Response for indicating status of the response and message in case of errors

class BaseResponses<T> {
  late Status status;
  late T data;
  late String message;

  BaseResponses.loading(this.message) : status = Status.loading;

  BaseResponses.completed(this.data) : status = Status.completed;

  BaseResponses.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { loading, completed, error }
