import FeedbackModel from "../models/feedbackModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function getAllFeedbacks() {
  const feedbackModel = await FeedbackModel.find({});
  if (!feedbackModel) {
    throw ResponseError(401, " No feedbacks are entered!");
  }
  return feedbackModel;
}

export async function getfeedbackbyId(id) {
  const feedback = await FeedbackModel.findById(id);
  if (!feedback) {
    throw ResponseError(401, "No feedback from ${id}");
  }
  return feedback;
}

export async function addFeedback(feed) {
  const newFeedback = await FeedbackModel.create(feed);
  return newFeedback;
}
