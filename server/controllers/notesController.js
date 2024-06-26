import {
  addNote,
  deleteNote,
  getAllNotes,
  getNote,
  getNotesByYear,
  updateNote,
} from "../services/notesServices.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

export async function UploadNoteController(req, res) {
  try {
    res.status(200).json({
      message: "Uploaded successfully",
      filePath: `/notes/${req.file.filename}`,
    });
  } catch (error) {
    res.status(404).json({
      message: "Uploading Failed",
    });
  }
}

export async function GetAllNotesController(req, res) {
  try {
    if (req.headers["year"]) {
      const response = await getNotesByYear(req.headers["year"]);
      return RestResponse(res, 200, null, response);
    } else {
      const response = await getAllNotes();
      return RestResponse(res, 200, null, response);
    }
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetNoteByIdContoller(req, res) {
  try {
    const { id } = req.params;
    const response = await getNote(id);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function AddNoteContoller(req, res) {
  try {
    const {
      title,
      description,
      filepath,
      createdDate,
      uploadedBy,
      profileImage,
      year,
    } = req.body;
    const noteData = {
      title,
      description,
      filepath,
      createdDate,
      uploadedBy,
      profileImage,
      year,
    };
    const response = await addNote(noteData);
    return res.status(200).json(response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function UpdateNoteContoller(req, res) {
  try {
    const { id } = req.params;
    const { title, description, filepath, uploadedBy } = req.body;
    const updatedNoteData = { title, description, filepath, uploadedBy };
    const response = await updateNote(id, updatedNoteData);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeleteNoteContoller(req, res) {
  try {
    const { id } = req.params;
    const response = await deleteNote(id);
    return res.status(200).json(response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
