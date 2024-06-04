import Joi from "joi";
import ResponseError from "../../utils/RestResponseError.js";
import { RestResponseError } from "../../utils/RestResponse.js";

export function StudentRegistrationValidation(req, res, next) {
  const schema = Joi.object({
    fullName: Joi.string().min(3).max(100).required().messages({
      "string.base": '"fullName" should be a type of text',
      "string.empty": '"fullName" cannot be an empty field',
      "string.min": '"fullName" should have a minimum length of {#limit}',
      "string.max": '"fullName" should have a maximum length of {#limit}',
      "any.required": '"fullName" is a required field',
    }),
    fatherName: Joi.string().min(3).max(100).required().messages({
      "string.base": '"fatherName" should be a type of text',
      "string.empty": '"fatherName" cannot be an empty field',
      "string.min": '"fatherName" should have a minimum length of {#limit}',
      "string.max": '"fatherName" should have a maximum length of {#limit}',
      "any.required": '"fatherName" is a required field',
    }),
    dob: Joi.date().iso().required().messages({
      "date.base": '"dob" should be a valid date',
      "date.format": '"dob" should be in ISO format',
      "any.required": '"dob" is a required field',
    }),
    gender: Joi.string().valid("Male", "Female", "Other").required().messages({
      "string.base": '"gender" should be a type of text',
      "any.only": '"gender" must be one of [Male, Female, Other]',
      "any.required": '"gender" is a required field',
    }),
    course: Joi.string().valid("MCA", "MBA").required().messages({
      "string.base": '"course" should be a type of text',
      "any.only": '"course" must be one of [MCA, MBA]',
      "any.required": '"course" is a required field',
    }),
    courseYear: Joi.number().integer().min(1).required().messages({
      "number.base": '"courseYear" should be a type of number',
      "number.min": '"courseYear" should have a minimum value of {#limit}',
      "any.required": '"courseYear" is a required field',
    }),
    email: Joi.string().email().required().messages({
      "string.base": '"email" should be a type of text',
      "string.email": '"email" must be a valid email',
      "any.required": '"email" is a required field',
    }),
    studentPhone: Joi.string()
      .pattern(/^\d{10}$/)
      .required()
      .messages({
        "string.pattern.base": '"studentPhone" must be a 10-digit number',
        "any.required": '"studentPhone" is a required field',
      }),
    parentPhone: Joi.string()
      .pattern(/^\d{10}$/)
      .required()
      .messages({
        "string.pattern.base": '"parentPhone" must be a 10-digit number',
        "any.required": '"parentPhone" is a required field',
      }),
    password: Joi.string()
      .pattern(
        /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{3,30}$/
      )
      .required()
      .messages({
        "string.pattern.base":
          '"password" must be 3-30 characters long, include at least one uppercase letter, one lowercase letter, one digit, and one special character',
        "any.required": '"password" is a required field',
      }),
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
    email: Joi.string().email().required().messages({
      "string.base": '"email" should be a type of text',
      "string.email": '"email" must be a valid email',
      "any.required": '"email" is a required field',
    }),
    password: Joi.string().required(),
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
