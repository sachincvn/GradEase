const StudentModel = require("../../models/StudentModel");

const RegisterStudentController = async (req, res) => {
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
};

module.exports = RegisterStudentController;
