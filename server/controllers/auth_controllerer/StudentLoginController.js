const StudentModel = require("../../models/StudentModel");

const StudentLoginController = async (req, res) => {
  try {
    const existingStudent = await StudentModel.findOne({
      email: req.body.email,
    });
    if (!existingStudent) {
      return res
        .status(400)
        .json({ message: "Invalid email, email is not registered" });
    }

    const isPasswordCorrect = await bcrypt.compare(
      req.body.password,
      existingStudent.password
    );

    if (!isPasswordCorrect) {
      return res.status(400).json({
        message: "Invalid password, please enter the correct password",
      });
    }

    const tokenObject = {
      _id: existingStudent._id,
      fullName: existingStudent.fullName,
      email: existingStudent.email,
    };

    const jwtToken = jwt.sign(tokenObject, process.env.JWT_SECRET, {
      expiresIn: "12h",
    });
    res.status(200).json({
      message: "Successfully Logedin",
      authToken: jwtToken,
      data: tokenObject,
    });
  } catch (error) {
    return res.status(500).json({ message: "error", error: error });
  }
};

module.exports = StudentLoginController;
