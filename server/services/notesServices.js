import NotesModel from "../models/noteModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function getAllNotes() {
  const notesModel = await NotesModel.find({});
  if (!notesModel) {
    throw ResponseError(401, "Notes not found");
  }
  return notesModel;
}

export async function getNote(id) {
  const note = await NotesModel.findById(id);
  if (!note) {
    throw ResponseError(401, "Note not found");
  }
  return note;
}

export async function addNote(noteData) {
  const newNote = await NotesModel.create(noteData);
  return newNote;
}

export async function deleteNote(id) {
  const deleteNote = await NotesModel.findByIdAndDelete(id);
  if (!deleteNote) {
    throw ResponseError(401, "Note not found");
  }
  return deleteNote;
}

export async function updateNote(id, updatedNote) {
  const note = await NotesModel.findByIdAndUpdate(id, updatedNote, {
    new: true,
  });
  if (!note) {
    throw new Error("Note not found");
  }
  return note;
}
