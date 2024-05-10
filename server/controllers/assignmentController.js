import{
    addAssignment,
    getAllAssignments,
    getAssignment,
    deleteAssignment,
    updateAssignment,
} from "../services/assignmentService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

export async function UploadAssignmentController(req, res) {
  try {
    res.status(200).json({
      message: "Uploaded successfully",
      filePath: `/notes/${req.file.filename}`,
    });
  } catch (error) {
    res.status(404).json({
      message: "Uploading Failed",
    });
  }
}

export async function GetAllAssignmentsController(req, res) {
  try {
    const response = await getAllAssignments();
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetAssignmentByIdContoller(req, res) {
  try {
    const { id } = req.params;
    const response = await getAssignment(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function AddAssignmentContoller(req, res) {
  try {
    const { title, description, filepath, createdDate, uploadedBy } = req.body;
    const noteData = {
      title,
      description,
      filepath,
      createdDate,
      uploadedBy,
    };
    const response = await addAssignment(noteData);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function UpdateAssignmentContoller(req, res) {
  try {
    const { id } = req.params;
    const { title, description, filepath, uploadedBy } = req.body;
    const updatedAssignemntData = { title, description, filepath, uploadedBy };
    const response = await updateAssignment(id, updatedAssignemntData);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeleteAssignmentContoller(req, res) {
  try {
    const { id } = req.params;
    const response = await deleteAssignment(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
