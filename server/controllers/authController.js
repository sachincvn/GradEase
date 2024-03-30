import { loginAdmin, loginStudent } from "../services/authService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

// Student Login Controller
export async function StudentLoginController(req, res) {
  try {
    const { email, password } = req.body;
    const jwtToken = await loginStudent(email, password);
    return RestResponse(res, 200, "Successfully Login", jwtToken);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

// Admin Login Controller
export async function AmdinLoginController(req, res) {
  try {
    const { email, password } = req.body;
    const jwtToken = await loginAdmin(email, password);
    return RestResponse(res, 200, "Successfully Login", jwtToken);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
