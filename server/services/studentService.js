import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import StudentModel from "../models/studentModel.js";
import ResponseError from "../utils/RestResponseError.js";
import PostModel from "../models/postModel.js";
import NotesModel from "../models/noteModel.js";
import FeedbackModel from "../models/feedbackModel.js";
import AssignmentsModel from "../models/assignmentModel.js";
import MessageModel from "../models/messageModel.js";

export async function registerStudent(studentModel) {
  const existingStudent = await StudentModel.findOne({
    email: studentModel.email,
  });

  if (existingStudent) {
    throw new ResponseError(
      404,
      "Student already exists with this email address"
    );
  }

  studentModel.password = await bcrypt.hash(studentModel.password, 10);
  const response = await studentModel.save();
  response.password = undefined;
  return response;
}

export async function getStudentByEmail(email) {
  const studentDetail = await StudentModel.findOne({ email }, { password: 0 });
  if (!studentDetail) {
    throw new ResponseError(404, "Invalid email, Student not found");
  }
  return studentDetail;
}

export async function getAllStudentsDetails() {
  const studentDetail = await StudentModel.find({}, { password: 0 });
  if (!studentDetail) {
    throw new ResponseError(404, "No data found");
  }
  return studentDetail;
}

export async function updateStudentDetail(email, updatedData) {
  const updatedStudent = await StudentModel.findOneAndUpdate(
    { email },
    updatedData,
    { new: true }
  );

  if (!updatedStudent) {
    throw new ResponseError(404, "Invalid email, Student not found");
  }

  return updatedStudent;
}

export async function deleteStudentDetail(email, updatedData) {
  const deleteStudent = await StudentModel.findOneAndDelete({ email });

  if (!deleteStudent) {
    throw new ResponseError(404, "Invalid email, Student not found");
  }
  if (deleteStudent) {
    await Promise.all([
      PostModel.deleteMany({ author: deleteStudent._id }),
      PostModel.updateMany(
        { "replies.author": deleteStudent._id },
        { $pull: { replies: { author: deleteStudent._id } } }
      ),
      NotesModel.deleteMany({ "uploadedBy.email": deleteStudent.email }),
      MessageModel.deleteMany({ sender: deleteStudent._id }),
      FeedbackModel.deleteMany({ "user.email": deleteStudent.email }),
      AssignmentsModel.deleteMany({ "uploadedBy.email": deleteStudent.email }),
    ]);
  }
  return deleteStudent;
}
