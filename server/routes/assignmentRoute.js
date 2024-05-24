import { Router } from "express";
import {
  UploadAssignmentController,
  GetAllAssignmentsController,
  GetAssignmentByIdContoller,
  AddAssignmentContoller,
  UpdateAssignmentContoller,
  DeleteAssignmentContoller,
  GetAssignmentsByYearCourseController,
} from "../controllers/assignmentController.js";
import { FileUploader } from "../utils/fileUploader.js";

const assignmentsRoute = Router();

assignmentsRoute.post(
  "/upload",
  FileUploader("upload/assignments", "file"),
  UploadAssignmentController
);

assignmentsRoute.get("/:course/:year/", GetAssignmentsByYearCourseController);
assignmentsRoute.post("/", AddAssignmentContoller);
assignmentsRoute.get("/", GetAllAssignmentsController);
assignmentsRoute.get("/:id", GetAssignmentByIdContoller);
assignmentsRoute.put("/:id", UpdateAssignmentContoller);
assignmentsRoute.delete("/:id", DeleteAssignmentContoller);

export default assignmentsRoute;
