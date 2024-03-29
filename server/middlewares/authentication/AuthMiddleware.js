const jwtToken = require("jsonwebtoken");
const RestResponse = require("../../utils/RestResponse");

module.exports = {
  AuthAdminMiddleware: (req, res, next) => {
    try {
      if (!req.headers["authorization"]) {
        return res
          .status(403)
          .json(RestResponse(403, "Authorization token is not provided"));
      }

      const decodedToken = jwtToken.verify(
        req.headers["authorization"],
        process.env.JWT_ADMIN_SECRET
      );
      if (!decodedToken) {
        return res.status(403).json(RestResponse(403, "Invalid token"));
      }
      return next();
    } catch (error) {
      console.log(error);
      return res.status(403).json(RestResponse(403, "error", error));
    }
  },

  AuthStudentMiddleware: (req, res, next) => {
    try {
      if (!req.headers["authorization"]) {
        return res
          .status(403)
          .json(RestResponse(403, "Authorization token is not provided"));
      }

      var decodedToken = undefined;

      try {
        decodedToken = jwtToken.verify(
          req.headers["authorization"],
          process.env.JWT_STUDENT_SECRET
        );
      } catch (error) {
        decodedToken = jwtToken.verify(
          req.headers["authorization"],
          process.env.JWT_ADMIN_SECRET
        );
      }

      if (!decodedToken) {
        return res.status(403).json(RestResponse(403, "Invalid token"));
      }
      return next();
    } catch (error) {
      return res.status(403).json(RestResponse(403, "error", error));
    }
  },
};
