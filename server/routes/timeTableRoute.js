import { Router } from "express";
import {
  CreateTimeTableController,
  DeleteTimeTableController,
  GetAllTimeTableController,
  GetTimeTableController,
  UpdateTimeTableController,
} from "../controllers/timeTableController.js";
const timeTableRoute = Router();

timeTableRoute.get("/", GetAllTimeTableController);
timeTableRoute.post("/", CreateTimeTableController);
timeTableRoute.get("/:course/:year/:section", GetTimeTableController);
timeTableRoute.put("/:course/:year/:section", UpdateTimeTableController);
timeTableRoute.delete("/:course/:year/:section", DeleteTimeTableController);

export default timeTableRoute;
