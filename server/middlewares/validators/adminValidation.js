import Joi from "joi";
import { RestResponseError } from "../../utils/RestResponse.js";
import { default as ResponseError } from "../../utils/RestResponseError.js";

export function AdminRegistrationValidation(req, res, next) {
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
}

export function AdminLoginValidation(req, res, next) {
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
}
