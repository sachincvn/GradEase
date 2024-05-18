import { Router } from "express";
import {
  AddFeedbackContoller,
  GetAllFeedbacksController,
  GetFeedbackByIdController,
} from "../controllers/feedbackController.js";

const feedbackRoute = Router();

feedbackRoute.get("/", GetAllFeedbacksController);
feedbackRoute.get("/:id", GetFeedbackByIdController);
feedbackRoute.post("/", AddFeedbackContoller);

export default feedbackRoute;
