const AdminModel = require("../../models/AdminModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const RestResponse = require("../../utils/RestResponse");

const AdminLoginController = async (req, res) => {
  try {
    const adminModel = await AdminModel.findOne({ email: req.body.email });

    if (!adminModel) {
      return res
        .status(400)
        .json(RestResponse(400, "Invalid email, email is not registered"));
    }

    const isPasswordCorrect = await bcrypt.compare(
      req.body.password,
      adminModel.password
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
      _id: adminModel._id,
      fullName: adminModel.fullName,
      email: adminModel.email,
    };

    const jwtToken = jwt.sign(tokenObject, process.env.JWT_ADMIN_SCRET);
    res.status(200).json(RestResponse(200, "Successfully Login", jwtToken));
  } catch (error) {
    return res.status(500).json(RestResponse(500, "error", error));
  }
};

module.exports = AdminLoginController;
