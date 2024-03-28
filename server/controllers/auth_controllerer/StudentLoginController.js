const StudentModel = require("../../models/StudentModel");
const RestResponse = require("../../utils/RestResponse");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const StudentLoginController = async (req, res) => {
  try {
    const existingStudent = await StudentModel.findOne({
      email: req.body.email,
    });
    if (!existingStudent) {
      return res
        .status(400)
        .json(RestResponse(400, "Invalid email, email is not registered"));
    }

    const isPasswordCorrect = await bcrypt.compare(
      req.body.password,
      existingStudent.password
    );

    if (!isPasswordCorrect) {
      return res
        .status(400)
        .json(
          RestResponse(
            400,
            "Invalid password, please enter the correct password"
          )
        );
    }

    const tokenObject = {
      _id: existingStudent._id,
      fullName: existingStudent.fullName,
      email: existingStudent.email,
    };

    const jwtToken = jwt.sign(tokenObject, process.env.JWT_STUDENT_SECRET, {
      expiresIn: "12h",
    });
    res.status(200).json(RestResponse(200, "Successfully Login", jwtToken));
  } catch (error) {
    console.log(error);
    return res.status(500).json(RestResponse(500, "error", error));
  }
};

module.exports = StudentLoginController;
