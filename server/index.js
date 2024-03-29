import express, { json } from "express";
const app = express();
import dotenv from "dotenv";
dotenv.config();
import "./config/dbConfig.js";
import studentRoute from "./routes/studentRoute.js";
import { errorMiddleware } from "./middlewares/errorMiddleware.js";

app.use(express.json());

const apiBasePath = "/api/v1/";

app.use(`${apiBasePath}student/`, studentRoute);

app.get("/", (req, res) => {
  res.status(200).json({ message: "Welcome to GradEase" });
});

app.use(errorMiddleware);
const port = process.env.PORT || 8080;

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
