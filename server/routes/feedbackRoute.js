import { Router } from "express";
import {
  CreateFeedbackContoller,
  GetAllFeedbacksController,
} from "../controllers/feedbackController.js";

const feedbackRoute = Router();

feedbackRoute.get("/", GetAllFeedbacksController);
feedbackRoute.post("/", CreateFeedbackContoller);

export default feedbackRoute;
