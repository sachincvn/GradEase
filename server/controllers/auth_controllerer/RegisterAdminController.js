const AdminModel = require("../../models/AdminModel");
const bcrypt = require("bcrypt");

const RegisterAdminController = async (req, res) => {
  const adminModel = new AdminModel(req.body);
  const existingAdmin = await AdminModel.findOne({
    email: req.body.email,
  });

  if (existingAdmin) {
    return res
      .status(400)
      .json({ message: "Student already exists with this email address" });
  }

  adminModel.password = await bcrypt.hash(req.body.password, 10);
  try {
    const response = await adminModel.save();
    response.password = undefined;
    return res.status(201).json({ message: "success", data: response });
  } catch (error) {
    return res.status(500).json({ message: "error", error: error });
  }
};

module.exports = RegisterAdminController;
