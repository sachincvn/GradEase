const express = require('express');
const { loginStudent, registerNewStudent } = require('../controllers/authController');
const authRoutes = express.Router();

  
authRoutes.post("/loginStudent", loginStudent);
  

authRoutes.post("/registerNewStudent", registerNewStudent);

module.exports = authRoutes