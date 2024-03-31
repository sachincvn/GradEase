import { addAssignment } from "../services/assignmentService.js";
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