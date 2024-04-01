import { addAssignment, deleteAssignment, getAssignment, getAssignmentByID, updateAssignment } from "../services/assignmentService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

export async function AddAssignmentController(req , res){
    try {
        const { title, description, subjectName , submissionDate } = req.body;
        const assignmentData = {
      title,
      description,
      subjectName,
      submissionDate
    };
    const response = await addAssignment(assignmentData);
    return RestResponse(res, 200, null, response);

    } catch (error) {
        return RestResponseError(res ,error);
    }
}

export async function getAssignmentController(req, res){
    try {
        const response = await getAssignment();
        return RestResponse(res, 200, null, response);
    } catch (error) {
         return RestResponseError(res ,error);
    }
}

export async function GetAssignmentByIdContoller(req, res) {
  try {
    const { id } = req.params;
    const response = await getAssignmentByID(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}


export async function deleteAssignmentController(req, res) {
  try {
    const { id } = req.params;
    const response = await deleteAssignment(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function UpdateAssignmentContoller(req, res) {
  try {
    const { id } = req.params;
    const { title, description,subjectName,submissionDate } = req.body;
    const updatedAssignment = { title, description,subjectName,submissionDate };
    const response = await updateAssignment(id, updatedAssignment);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}