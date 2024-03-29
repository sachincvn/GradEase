const express = require("express");
const {
  AuthAdminMiddleware,
} = require("../middlewares/authentication/AuthMiddleware");
const GetAllStudentsController = require("../controllers/students_controller/GetAllStudentsController");

const StudentRoutes = express.Router();

StudentRoutes.get(
  "/getAllStudents",
  AuthAdminMiddleware,
  GetAllStudentsController
);

module.exports = StudentRoutes;
