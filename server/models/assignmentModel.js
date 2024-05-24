import { Schema, model } from "mongoose";

const assignmentSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  filepath: {
    type: String,
  },
  createdDate: {
    type: Date,
    default: Date.now,
  },
  submittionDate: {
    type: Date,
    required: true,
  },
  year: {
    type: Number,
    required: true,
  },
  course: {
    type: String,
    required: true,
  },
  uploadedBy: {
    fullName: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
  },
});

const AssignmentsModel = model("Assignment", assignmentSchema);
export default AssignmentsModel;
