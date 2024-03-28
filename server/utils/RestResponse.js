const RestResponse = (statusCode, message, data = null) => {
  return { statusCode, message, data };
};

module.exports = RestResponse;
