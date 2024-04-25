import { Router } from "express";
import {
  getCommunitiesByCourseYearController,
  createCommunityController,
  joinCommunityController,
  sendMessageController,
  getCommunityMessagesController,
} from "../controllers/communityController.js";

const communityRoutes = Router();

communityRoutes.post("/", createCommunityController);
communityRoutes.post("/send-message", sendMessageController);
communityRoutes.post("/join", joinCommunityController);
communityRoutes.get("/:communityId/messages", getCommunityMessagesController);
communityRoutes.get("/:course/:year", getCommunitiesByCourseYearController);
export default communityRoutes;
