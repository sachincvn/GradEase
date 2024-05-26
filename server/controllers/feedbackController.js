import FeedbackModel from "../models/feedbackModel.js";
import { addFeedback, getAllFeedbacks } from "../services/feedbackService.js";
import { RestResponseError, RestResponse } from "../utils/RestResponse.js";

export async function GetAllFeedbacksController(req, res) {
  try {
    const response = await getAllFeedbacks();
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function CreateFeedbackContoller(req, res) {
  try {
    const { name, email, message } = req.body;
    const feedback = new FeedbackModel({ name, email, message });
    const response = await addFeedback(feedback);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
