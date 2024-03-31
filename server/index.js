import express from "express";
const app = express();
import dotenv from "dotenv";
dotenv.config();
import "./config/dbConfig.js";
import studentRoute from "./routes/studentRoute.js";
import { errorMiddleware } from "./middlewares/errorMiddleware.js";
import authRoute from "./routes/authRoute.js";
import timeTableRoute from "./routes/timeTableRoute.js";
import notesRoute from "./routes/notesRoute.js";
import assignmentRoute from "./routes/assignmentRoute.js";

app.use(express.json());

const apiBasePath = "/api/v1/";

app.use(`${apiBasePath}student/`, studentRoute);
app.use(`${apiBasePath}auth/`, authRoute);
app.use(`${apiBasePath}timetable/`, timeTableRoute);
app.use(`${apiBasePath}notes/`, notesRoute);
app.use(`${apiBasePath}assignment/`, assignmentRoute);


app.get("/", (req, res) => {
  res.status(200).json({ message: "Welcome to GradEase" });
});

app.use(errorMiddleware);
const port = process.env.PORT || 8080;

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
