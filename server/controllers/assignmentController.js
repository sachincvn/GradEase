import {
  addAssignment,
  getAllAssignments,
  getAssignment,
  deleteAssignment,
  updateAssignment,
  getAssignmentsByCourseYear,
} from "../services/assignmentService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

export async function UploadAssignmentController(req, res) {
  try {
    res.status(200).json({
      message: "Uploaded successfully",
      filePath: `/assignments/${req.file.filename}`,
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

export async function GetAssignmentsByYearCourseController(req, res) {
  try {
    const { course, year } = req.params;
    const response = await getAssignmentsByCourseYear(course, year);
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
    const {
      title,
      description,
      filepath,
      uploadedBy,
      course,
      year,
      submittionDate,
    } = req.body;
    const noteData = {
      title,
      description,
      filepath,
      uploadedBy,
      course,
      year,
      submittionDate,
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
