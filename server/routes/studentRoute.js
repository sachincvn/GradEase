import { Router } from "express";
import {
  DeleteStudentDetailController,
  GetAllStudentsController,
  GetStudentByEmailController,
  RegisterNewStudentController,
  UpdateStudentDetailController,
} from "../controllers/studentController.js";
import { AuthStudentMiddleware } from "../middlewares/authentication/authStudentMiddleware.js";
import { StudentRegistrationValidation } from "../middlewares/validators/studentValidation.js";
import { AuthAdminMiddleware } from "../middlewares/authentication/authAdminMiddleware.js";
const studentRoute = Router();

studentRoute.post(
  "/register",
  StudentRegistrationValidation,
  RegisterNewStudentController
);

studentRoute.get(
  "/getAllStudents",
  AuthStudentMiddleware,
  GetAllStudentsController
);

studentRoute.get("/:email", AuthStudentMiddleware, GetStudentByEmailController);
studentRoute.put(
  "/:email",
  AuthStudentMiddleware,
  UpdateStudentDetailController
);

studentRoute.delete(
  "/:email",
  AuthStudentMiddleware,
  DeleteStudentDetailController
);

export default studentRoute;
