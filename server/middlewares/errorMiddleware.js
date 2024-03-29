export function errorMiddleware(error, req, res, next) {
  console.error(error);
  const status = error.statusCode || 500;
  const message = error.message || "Internal Server Error";
  res.status(status).json({ message });
}
