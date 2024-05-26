import { Schema, model } from "mongoose";
import { CourseEnum, GenderEnum, RoleEnum } from "../utils/enum.js";
import PostModel from "../models/postModel.js";
import NotesModel from "../models/noteModel.js";
import MessageModel from "../models/messageModel.js";
import FeedbackModel from "../models/feedbackModel.js";
import AssignmentsModel from "../models/assignmentModel.js";

const studentSchema = new Schema({
  fullName: {
    type: String,
    required: true,
  },
  fatherName: {
    type: String,
    required: true,
  },
  dob: {
    type: Date,
    required: true,
  },
  gender: {
    type: String,
    enum: GenderEnum,
    required: true,
  },
  course: {
    type: String,
    enum: CourseEnum,
    required: true,
  },
  courseYear: {
    type: Number,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  studentPhone: {
    type: String,
    required: true,
  },
  parentPhone: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  profileImage: {
    type: String,
    required: false,
  },
  section: {
    type: String,
    default: "A",
  },
  isApproved: {
    type: Boolean,
    default: false,
  },
  role: {
    type: String,
    enum: RoleEnum,
    default: "Student",
  },
});

const StudentModel = model("Student", studentSchema);

export default StudentModel;
