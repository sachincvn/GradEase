import {
  deleteStudentDetail,
  getAllStudentsDetails,
  getStudentByEmail,
  registerStudent,
  updateStudentDetail,
} from "../services/studentService.js";
import StudentModel from "../models/studentModel.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

// Register new student controller
export async function RegisterNewStudentController(req, res) {
  try {
    const studentModel = new StudentModel(req.body);
    const response = await registerStudent(studentModel);
    return RestResponse(res, 201, "Successfully Registered", response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

//Getstudent detail controller
export async function GetStudentByEmailController(req, res) {
  try {
    const { email } = req.params;
    const response = await getStudentByEmail(email);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

//get all students controller
export async function GetAllStudentsController(req, res) {
  try {
    const response = await getAllStudentsDetails();
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

// update student by email controller
export async function UpdateStudentDetailController(req, res) {
  try {
    const { email } = req.params;
    const updatedData = req.body;
    const updatedStudent = await updateStudentDetail(email, updatedData);
    updatedStudent.password = undefined;
    return RestResponse(
      res,
      200,
      "Student details updated successfully",
      updatedStudent
    );
  } catch (error) {
    return RestResponseError(res, error);
  }
}

//delete student by email
export async function DeleteStudentDetailController(req, res) {
  try {
    const { email } = req.params;
    const deletedStudent = await deleteStudentDetail(email);
    deletedStudent.password = undefined;
    return RestResponse(
      res,
      200,
      "Student details updated successfully",
      deletedStudent
    );
  } catch (error) {
    return RestResponseError(res, error);
  }
}
