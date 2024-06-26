import { Schema, model } from "mongoose";

const notesSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  filepath: {
    type: String,
    required: true,
  },
  createdDate: {
    type: Date,
    default: Date.now,
  },
  uploadedBy: {
    fullName: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    profileImage: {
      type: String,
    },
  },
  year: {
    type: Number,
    required: true,
  },
});

const NotesModel = model("Note", notesSchema);
export default NotesModel;
