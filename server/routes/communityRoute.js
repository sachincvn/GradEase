import { Router } from "express";
import {
  getCommunitiesByCourseYearController,
  createCommunityController,
  joinCommunityController,
} from "../controllers/communityController.js";

const communityRoutes = Router();

communityRoutes.post("/", createCommunityController);
communityRoutes.get("/:course/:year", getCommunitiesByCourseYearController);
communityRoutes.post("/join", joinCommunityController);
export default communityRoutes;
