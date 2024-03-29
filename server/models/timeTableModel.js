import mongoose from "mongoose";

const timetableSchema = new mongoose.Schema({
  course: String,
  year: Number,
  section: String,
  timetable: {
    Monday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
    Tuesday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
    Wednesday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
    Thursday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
    Friday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
    Saturday: [
      {
        SubjectName: String,
        TeacherName: String,
        Time: String,
      },
    ],
  },
});

const Timetable = mongoose.model("Timetable", timetableSchema);

export default Timetable;
