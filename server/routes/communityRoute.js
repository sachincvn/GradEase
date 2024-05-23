import { Router } from "express";
import {
  getCommunitiesByCourseYearController,
  createCommunityController,
  joinCommunityController,
  sendMessageController,
  getCommunityMessagesController,
  getAllCommunitiesController,
  UploadImageController,
  deleteCommunityController,
  updateCommunityCntroller,
} from "../controllers/communityController.js";
import { FileUploader } from "../utils/fileUploader.js";

const communityRoutes = Router();

communityRoutes.post(
  "/uploadImage",
  FileUploader("upload/communityImages", "file"),
  UploadImageController
);
communityRoutes.post("/", createCommunityController);
communityRoutes.post("/send-message", sendMessageController);
communityRoutes.post("/join", joinCommunityController);
communityRoutes.get("/:communityId/messages", getCommunityMessagesController);
communityRoutes.get("/:course/:year", getCommunitiesByCourseYearController);
communityRoutes.get("/getAllCommunites", getAllCommunitiesController);
communityRoutes.delete("/:id", deleteCommunityController);
communityRoutes.put("/:id", updateCommunityCntroller);
export default communityRoutes;
