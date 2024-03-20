const express = require("express");
const StudentLoginController = require("../controllers/auth_controllerer/StudentLoginController");
const {
  StudentRegistrationValidation,
  StudentLoginValidation,
} = require("../middlewares/validators/StudentValidation");
const RegisterAdminController = require("../controllers/auth_controllerer/RegisterAdminController");
const {
  AdminRegistrationValidation,
  AdminLoginValidation,
} = require("../middlewares/validators/AdminValidation");
const AdminLoginController = require("../controllers/auth_controllerer/AdminLoginController");

const AuthRoutes = express.Router();

AuthRoutes.post(
  "/registerNewStudent",
  StudentRegistrationValidation,
  RegisterAdminController
);

AuthRoutes.post("/login", StudentLoginValidation, StudentLoginController);

AuthRoutes.post(
  "/adminRegister",
  AdminRegistrationValidation,
  RegisterAdminController
);

AuthRoutes.post("/adminLogin", AdminLoginValidation, AdminLoginController);

module.exports = AuthRoutes;
