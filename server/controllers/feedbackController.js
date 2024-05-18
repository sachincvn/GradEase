import {
  addFeedback,
  getAllFeedbacks,
  getfeedbackbyId,
} from "../services/feedbackService.js";
import { RestResponseError, RestResponse } from "../utils/RestResponse.js";

export async function GetAllFeedbacksController(req, res) {
  try {
    const response = await getAllFeedbacks();
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetFeedbackByIdController(req, res) {
  try {
    const { id } = req.params;
    const response = await getfeedbackbyId(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function AddFeedbackContoller(req, res) {
  try {
    const { user, comments, submittedDate } = req.body;
    const feedbackdata = {
      user,
      comments,
      submittedDate,
    };
    const response = await addFeedback(feedbackdata);
    return res.status(200).json(response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
