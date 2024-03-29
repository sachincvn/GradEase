import jwtToken from "jsonwebtoken";
import ResponseError from "../../utils/RestResponseError.js";
import { RestResponseError } from "../../utils/RestResponse.js";

export async function AuthAdminMiddleware(req, res, next) {
  try {
    if (!req.headers["authorization"]) {
      return RestResponseError(
        res,
        new ResponseError(403, "Authorization token is not provided")
      );
    }

    const decodedToken = jwtToken.verify(
      req.headers["authorization"],
      process.env.JWT_ADMIN_SECRET
    );
    if (!decodedToken) {
      return RestResponseError(
        res,
        new ResponseError(401, "Unauthorized invalid auth token")
      );
    }
    return next();
  } catch (error) {
    return RestResponseError(
      res,
      new ResponseError(401, "Unauthorized invalid auth token")
    );
  }
}
