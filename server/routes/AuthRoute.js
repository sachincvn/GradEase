const express = require("express");
const RegisterNewStudent = require("../controllers/auth_controllerer/RegisterStudentController");
const StudentLoginController = require("../controllers/auth_controllerer/StudentLoginController");
const {
  StudentRegistrationValidation,
  StudentLoginValidation,
} = require("../middlewares/validators/StudentValidation");
const RegisterAdminController = require("../controllers/auth_controllerer/RegisterAdminController");
const {
  AdminRegistrationValidation,
} = require("../middlewares/validators/AdminValidation");

const AuthRoutes = express.Router();

AuthRoutes.post(
  "/registerNewStudent",
  StudentRegistrationValidation,
  RegisterNewStudent
);

AuthRoutes.post("/login", StudentLoginValidation, StudentLoginController);

AuthRoutes.post(
  "/adminRegister",
  AdminRegistrationValidation,
  RegisterAdminController
);

// authRoutes.post("/adminLogin", studentLoginValidation, adminLogin);

module.exports = AuthRoutes;
