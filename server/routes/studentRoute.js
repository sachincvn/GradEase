import { Router } from "express";
import {
  GetAllStudentsController,
  GetStudentByEmailController,
  RegisterNewStudentController,
  StudentLoginController,
  UpdateStudentDetailController,
} from "../controllers/studentController.js";
import { AuthStudentMiddleware } from "../middlewares/authentication/authStudentMiddleware.js";
import {
  StudentLoginValidation,
  StudentRegistrationValidation,
} from "../middlewares/validators/studentValidation.js";
const studentRoute = Router();

studentRoute.post("/login", StudentLoginValidation, StudentLoginController);
studentRoute.post(
  "/register",
  StudentRegistrationValidation,
  RegisterNewStudentController
);
studentRoute.get("/:email", AuthStudentMiddleware, GetStudentByEmailController);
studentRoute.put("/:email", UpdateStudentDetailController);
studentRoute.get("/getAllStudents", GetAllStudentsController);

export default studentRoute;
