import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import StudentModel from "../models/studentModel.js";
import ResponseError from "../utils/RestResponseError.js";
import AdminModel from "../models/adminModel.js";

export async function loginStudent(email, password) {
  const existingStudent = await StudentModel.findOne({ email });

  if (!existingStudent) {
    throw new ResponseError(404, "Invalid email, email is not registered");
  }

  const isPasswordCorrect = await bcrypt.compare(
    password,
    existingStudent.password
  );

  if (!isPasswordCorrect) {
    throw new ResponseError(
      404,
      "Invalid password, please enter the correct password"
    );
  }

  if (!existingStudent.isApproved) {
    throw new ResponseError(
      404,
      "Account is not verified, please contact college admin"
    );
  }

  const tokenObject = {
    _id: existingStudent._id,
    fullName: existingStudent.fullName,
    email: existingStudent.email,
  };

  const jwtToken = jwt.sign(tokenObject, process.env.JWT_STUDENT_SECRET);

  return jwtToken;
}

export async function loginAdmin(email, password) {
  const adminModel = await AdminModel.findOne({ email });

  if (!adminModel) {
    throw new ResponseError(404, "Invalid email, email is not registered");
  }

  const isPasswordCorrect = await bcrypt.compare(password, adminModel.password);

  if (!isPasswordCorrect) {
    throw new ResponseError(
      404,
      "Invalid password, please enter the correct password"
    );
  }

  const tokenObject = {
    _id: adminModel._id,
    fullName: adminModel.fullName,
    email: adminModel.email,
  };

  const jwtToken = jwt.sign(tokenObject, process.env.JWT_ADMIN_SECRET);

  return jwtToken;
}
