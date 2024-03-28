const StudentModel = require("../../models/StudentModel");
const RestResponse = require("../../utils/RestResponse");

const GetAllStudentsController = async (req, res) => {
  try {
    var response = await StudentModel.find({}, { password: 0 });
    if (response) {
      return res.status(200).json(RestResponse(200, "success", response));
    }
    return res.status(403).json(RestResponse(403, "No data found"));
  } catch (error) {
    console.log(error);
    return res.status(500).json(RestResponse(500, "error", error));
  }
};

module.exports = GetAllStudentsController;
