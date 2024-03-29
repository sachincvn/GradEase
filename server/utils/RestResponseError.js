export default class ResponseError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.name = "ResponseError";
    this.statusCode = statusCode;
  }
}
