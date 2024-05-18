import { Router } from "express";
import {
  UploadAssignmentController,
  GetAllAssignmentsController,
  GetAssignmentByIdContoller,
  AddAssignmentContoller,
  UpdateAssignmentContoller,
  DeleteAssignmentContoller,
} from "../controllers/assignmentController.js";
import { FileUploader } from "../utils/fileUploader.js";

const AssignmentsRoute = Router();

AssignmentsRoute.post(
  "/upload",
  FileUploader("upload/Assignments", "file"),
  UploadAssignmentController
);

AssignmentsRoute.post("/", AddAssignmentContoller);
AssignmentsRoute.get("/", GetAllAssignmentsController);
AssignmentsRoute.get("/:id", GetAssignmentByIdContoller);
AssignmentsRoute.put("/", UpdateAssignmentContoller);
AssignmentsRoute.delete("/", DeleteAssignmentContoller);

export default AssignmentsRoute;
