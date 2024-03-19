const StudentModel = require("../models/StudentModel");
const bcrypt = require("bcrypt");
const jwt = require('jsonwebtoken')

module.exports = {
  registerNewStudent: async (req, res) => {
    const studentModel = new StudentModel(req.body);
    const existingStudent = await StudentModel.findOne({
      email: req.body.email,
    });

    if (existingStudent) {
      return res
        .status(400)
        .json({ message: "Student already exists with this email address" });
    }

    studentModel.password = await bcrypt.hash(req.body.password, 10);
    try {
      const response = await studentModel.save();
      response.password = undefined;
      return res.status(201).json({ message: "success", data: response });
    } catch (error) {
      return res.status(500).json({ message: "error", error: error });
    }
  },

  loginStudent: async (req, res) => {
    try {
      const existingStudent = await StudentModel.findOne({
        email: req.body.email,
      });
      if (!existingStudent) {
        return res
          .status(400)
          .json({ message: "Invalid email, email is not registered" });
      }

      const isPasswordCorrect = await bcrypt.compare(req.body.password, existingStudent.password);
      
      if(!isPasswordCorrect){
        return res
          .status(400)
          .json({ message: "Invalid password, please enter the correct password" });
      }

      const tokenObject = {
        _id: existingStudent._id,
        fullName : existingStudent.fullName,
        email : existingStudent.email
      }

      const jwtToken = jwt.sign(tokenObject, process.env.JWT_SECRET , {expiresIn : '12h'})
      res.status(200).json({ message: "Successfully Logedin", authToken : jwtToken, data : tokenObject });
    } catch (error) {
      return res.status(500).json({ message: "error", error: error });
    }
  },
};
