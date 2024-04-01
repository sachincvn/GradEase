import { Router } from "express";
import { AddAssignmentController,
    GetAssignmentByIdContoller,
    UpdateAssignmentContoller,
    deleteAssignmentController,
    getAssignmentController } from "../controllers/assignmentController.js";

const assignmentRoute = Router();

assignmentRoute.post("/",AddAssignmentController);
assignmentRoute.get("/",getAssignmentController);
assignmentRoute.delete("/:id",deleteAssignmentController);
assignmentRoute.put("/:id",UpdateAssignmentContoller);
assignmentRoute.get("/:id",GetAssignmentByIdContoller);

export default assignmentRoute;