export function RestResponse(res, statusCode, message, data = null) {
  return res.status(statusCode).json({ statusCode, message, data });
}

export function RestResponseError(res, error) {
  if (error.name === "ResponseError") {
    const { statusCode, message } = error;
    return res.status(statusCode).json({ statusCode, message });
  }
  return res.status(statusCode).json({
    statusCode: 500,
    message: `Internal Server Error - ${error.message}`,
  });
}
