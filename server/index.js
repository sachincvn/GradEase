import express from "express";
import http from "http";
import path from "path";
import { fileURLToPath } from "url";
const app = express();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const server = http.createServer(app);

import dotenv from "dotenv";
dotenv.config();
import "./config/dbConfig.js";
import studentRoute from "./routes/studentRoute.js";
import { errorMiddleware } from "./middlewares/errorMiddleware.js";
import authRoute from "./routes/authRoute.js";
import timeTableRoute from "./routes/timeTableRoute.js";
import notesRoute from "./routes/notesRoute.js";
import postRoute from "./routes/postRoute.js";
import communityRoutes from "./routes/communityRoute.js";
import { initializeSocket } from "./socket.js";

initializeSocket(server);
app.use(express.json());

// Serve static files from the 'upload' directory
app.use("/upload", express.static(path.join(__dirname, "upload")));

const apiBasePath = "/api/v1/";

app.use(`${apiBasePath}student/`, studentRoute);
app.use(`${apiBasePath}auth/`, authRoute);
app.use(`${apiBasePath}timetable/`, timeTableRoute);
app.use(`${apiBasePath}notes/`, notesRoute);
app.use(`${apiBasePath}post/`, postRoute);
app.use(`${apiBasePath}communites/`, communityRoutes);

app.get("/", (req, res) => {
  res.status(200).json({ message: "Welcome to GradEase" });
});

app.use(errorMiddleware);
const port = process.env.PORT || 8080;

server.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
