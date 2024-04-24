import { Router } from "express";
import {
  getCommunitiesByCourseYearController,
  createCommunityController,
  joinCommunityController,
  sendMessageController,
} from "../controllers/communityController.js";

const communityRoutes = Router();

communityRoutes.post("/", createCommunityController);
communityRoutes.post("/send-message", sendMessageController);
communityRoutes.get("/:course/:year", getCommunitiesByCourseYearController);
communityRoutes.post("/join", joinCommunityController);
export default communityRoutes;
