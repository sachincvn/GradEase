const AdminModel = require("../../models/AdminModel");
const bcrypt = require("bcrypt");
const RestResponse = require("../../utils/RestResponse");

const RegisterAdminController = async (req, res) => {
  const adminModel = new AdminModel(req.body);
  const existingAdmin = await AdminModel.findOne({
    email: req.body.email,
  });

  if (existingAdmin) {
    return res
      .status(400)
      .json(
        RestResponse(400, "Student already exists with this email address")
      );
  }

  adminModel.password = await bcrypt.hash(req.body.password, 10);
  try {
    const response = await adminModel.save();
    response.password = undefined;
    return res.status(201).json(RestResponse(201, "success", response));
  } catch (error) {
    return res.status(500).json(RestResponse(500, "error", error));
  }
};

module.exports = RegisterAdminController;
