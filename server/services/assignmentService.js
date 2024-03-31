import AssignmentModel from "../models/assignmentModel.js";

export async function addAssignment(assignmentData){

  const assignment = await AssignmentModel.create(assignmentData);
  return assignment;   
}

