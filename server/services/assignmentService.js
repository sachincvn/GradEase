import AssignmentModel from "../models/assignmentModel.js";
import ResponseError from "../utils/RestResponseError.js";


//Adding Assignment
export async function addAssignment(assignmentData){

  const newassignment = await AssignmentModel.create(assignmentData);
  return newassignment;   
}

//Getting Assignment
export async function getAssignment(assignmentData){
  const assignment = await AssignmentModel.find({});
  if(!assignment)
  {
    throw ResponseError(401,"Assignment Not found");
  }
  return assignment;
}

//Getting Assignment By ID
export async function getAssignmentByID(id) {
  const assignmentID = await AssignmentModel.findById(id);
  if (!assignmentID) {
    throw ResponseError(401, "Assignment not found");
  }
  return assignmentID;
}

//Deleting Assignment
export async function deleteAssignment(id) {
  const deleteAssignment = await AssignmentModel.findByIdAndDelete(id);
  if (!deleteAssignment) {
    throw ResponseError(401, "Assignment not found");
  }
  return deleteAssignment;
}

//Updating Assignment
export async function updateAssignment(id, updatedAssignment) {
  const updateAssign = await AssignmentModel.findByIdAndUpdate(id, updatedAssignment, {
    new: true,
  });
  if (!updateAssign) {
    throw new Error("Assignment not found");
  }
  return updateAssign;
}