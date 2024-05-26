import FeedbackModel from "../models/feedbackModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function getAllFeedbacks() {
  const feedbackModel = await FeedbackModel.find({});
  if (!feedbackModel) {
    throw ResponseError(401, " No feedbacks are entered!");
  }
  return feedbackModel;
}

export async function addFeedback(feedBack) {
  const feedback = new FeedbackModel(feedBack);
  await feedback.save();
  return feedBack;
}
