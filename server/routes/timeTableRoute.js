import { Router } from "express";
import {
  CreateTimeTableController,
  DeleteTimeTableController,
  GetAllTimeTableController,
  GetTimeTableController,
  UpdateTimeTableController,
} from "../controllers/timeTableController.js";
import { AuthAdminMiddleware } from "../middlewares/authentication/authAdminMiddleware.js";
import { AuthStudentMiddleware } from "../middlewares/authentication/authStudentMiddleware.js";
const timeTableRoute = Router();

timeTableRoute.get("/", AuthAdminMiddleware, GetAllTimeTableController);
timeTableRoute.post("/", AuthAdminMiddleware, CreateTimeTableController);
timeTableRoute.get(
  "/:course/:year/:section",
  AuthStudentMiddleware,
  GetTimeTableController
);
timeTableRoute.put(
  "/:course/:year/:section",
  AuthAdminMiddleware,
  UpdateTimeTableController
);
timeTableRoute.delete(
  "/:course/:year/:section",
  AuthAdminMiddleware,
  DeleteTimeTableController
);

export default timeTableRoute;
