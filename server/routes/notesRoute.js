import { Router } from "express";
import {
  AddNoteContoller,
  DeleteNoteContoller,
  GetAllNotesController,
  GetNoteByIdContoller,
  UpdateNoteContoller,
  UploadNoteController,
} from "../controllers/notesController.js";
import { FileUploader } from "../utils/fileUploader.js";

const notesRoute = Router();

notesRoute.post(
  "/upload",
  FileUploader("upload/notes", "file"),
  UploadNoteController
);
notesRoute.post("/", AddNoteContoller);
notesRoute.get("/", GetAllNotesController);
notesRoute.get("/:id", GetNoteByIdContoller);
notesRoute.put("/", UpdateNoteContoller);
notesRoute.delete("/", DeleteNoteContoller);

export default notesRoute;
