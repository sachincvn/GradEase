import Joi from "joi";
import ResponseError from "../../utils/RestResponseError.js";
import { RestResponseError } from "../../utils/RestResponse.js";

export function StudentRegistrationValidation(req, res, next) {
  const schema = Joi.object({
    fullName: Joi.string().min(3).max(100).required(),
    fatherName: Joi.string().min(3).max(100).required(),
    dob: Joi.date().iso().required(),
    gender: Joi.string().valid("Male", "Female", "Other").required(),
    course: Joi.string().valid("MCA", "MBA").required(),
    courseYear: Joi.number().integer().min(1).required(),
    email: Joi.string().email().required(),
    studentPhone: Joi.string()
      .pattern(/^\d{10}$/)
      .required(),
    parentPhone: Joi.string()
      .pattern(/^\d{10}$/)
      .required(),
    password: Joi.string()
      .pattern(/^[a-zA-Z0-9]{3,30}$/)
      .required(),
    profileImage: Joi.string(),
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

export function StudentLoginValidation(req, res, next) {
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
