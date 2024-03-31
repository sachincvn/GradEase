import { Router } from "express";
import { AddAssignmentController } from "../controllers/assignmentController.js";

const assignmentRoute = Router();

assignmentRoute.post("/",AddAssignmentController);
export default assignmentRoute;