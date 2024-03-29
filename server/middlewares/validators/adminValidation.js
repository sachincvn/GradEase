const Joi = require("joi");
const { RestResponseError } = require("../../utils/RestResponse.js");
const { default: ResponseError } = require("../../utils/RestResponseError.js");

const AdminRegistrationValidation = (req, res, next) => {
  const schema = Joi.object({
    fullName: Joi.string().min(3).max(100).required(),
    email: Joi.string().email().required(),
    password: Joi.string()
      .pattern(/^[a-zA-Z0-9]{3,30}$/)
      .required(),
  });

  const { error } = schema.validate(req.body);
  if (error) {
    return RestResponseError(
      res,
      new ResponseError(400, error.details[0].message)
    );
  }

  next();
};

const AdminLoginValidation = (req, res, next) => {
  const schema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string()
      .pattern(/^[a-zA-Z0-9]{3,30}$/)
      .required(),
  });

  const { error } = schema.validate(req.body);
  if (error) {
    return RestResponseError(
      res,
      new ResponseError(400, error.details[0].message)
    );
  }

  next();
};

module.exports = {
  AdminLoginValidation,
  AdminRegistrationValidation,
};
