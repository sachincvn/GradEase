const express = require('express');
const { loginStudent, registerNewStudent } = require('../controllers/authController');
const { studentLoginValidation, studentRegistrationValidation } = require('../middlewares/validators/studentValidation');
const authRoutes = express.Router();

authRoutes.post("/registerNewStudent",studentRegistrationValidation, registerNewStudent);
  
authRoutes.post("/login", studentLoginValidation, loginStudent);

module.exports = authRoutes