import { Router } from "express";
import { StudentLoginValidation } from "../middlewares/validators/studentValidation.js";
import {
  AmdinLoginController,
  StudentLoginController,
} from "../controllers/authController.js";
import { AdminLoginValidation } from "../middlewares/validators/adminValidation.js";
const authRoute = Router();

authRoute.post("/student", StudentLoginValidation, StudentLoginController);
authRoute.post("/admin", AdminLoginValidation, AmdinLoginController);

export default authRoute;
