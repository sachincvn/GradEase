import AssignmentsModel from "../models/assignmentModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function getAllAssignments() {
  const assignmentModel = await AssignmentsModel.find({});
  if (!assignmentModel) {
    throw ResponseError(401, "Assignment not found");
  }
  return assignmentModel;
}

export async function getAssignment(id) {
  const assignment = await AssignmentsModel.findById(id);
  if (!assignment) {
    throw ResponseError(401, "Assignment not found");
  }
  return assignment;
}

export async function addAssignment(assignmentData) {
  const newAssignment = await AssignmentsModel.create(assignmentData);
  return newAssignment;
}

export async function deleteAssignment(id) {
  const deleteassignment = await AssignmentsModel.findByIdAndDelete(id);
  if (!deleteassignment) {
    throw ResponseError(401, "Assignment not found");
  }
  return deleteassignment;
}

export async function updateAssignment(id, updatedAssignment) {
  const assignment = await AssignmentsModel.findByIdAndUpdate(id, updatedAssignment, {
    new: true,
  });
  if (!assignment) {
    throw new Error("Assignment not found");
  }
  return assignment;
}
