import { Router } from "express";
import {
  DeleteStudentDetailController,
  GetAllStudentsController,
  GetStudentByEmailController,
  RegisterNewStudentController,
  UpdateStudentDetailController,
  UploadStudentProfileController,
} from "../controllers/studentController.js";
import { AuthStudentMiddleware } from "../middlewares/authentication/authStudentMiddleware.js";
import { StudentRegistrationValidation } from "../middlewares/validators/studentValidation.js";
import { AuthAdminMiddleware } from "../middlewares/authentication/authAdminMiddleware.js";
import { FileUploader } from "../utils/fileUploader.js";
const studentRoute = Router();

studentRoute.post(
  "/uploadProfile",
  FileUploader("upload/studentProfiles", "file"),
  UploadStudentProfileController
);
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
