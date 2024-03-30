import Timetable from "../models/timeTableModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function createTimetable(course, year, section, timetableData) {
  const existingTimetable = await Timetable.findOne({
    course,
    year,
    section,
  });

  if (existingTimetable && existingTimetable.timetable) {
    throw new ResponseError(
      400,
      "Timetable for the provided class is already added"
    );
  }
  const timetable = new Timetable({
    course,
    year,
    section,
    timetable: timetableData,
  });
  await timetable.save();
  return timetable;
}

export async function getAllTimetable() {
  const timetable = await Timetable.find({});
  if (!timetable) {
    throw new ResponseError(404, "Timetable not found");
  }
  return timetable;
}

export async function getTimetable(course, year, section) {
  const timetable = await Timetable.findOne({ course, year, section });
  if (!timetable) {
    throw new ResponseError(404, "Timetable not found");
  }
  return timetable;
}

export async function updateTimetable(
  course,
  year,
  section,
  updatedTimetableData
) {
  const timetable = await Timetable.findOneAndUpdate(
    { course, year, section },
    { timetable: updatedTimetableData },
    { new: true }
  );
  if (!timetable) {
    throw new ResponseError(404, "Timetable not found");
  }
  return timetable;
}

export async function deleteTimetable(course, year, section) {
  const timetable = await Timetable.findOneAndDelete({
    course,
    year,
    section,
  });
  if (!timetable) {
    throw new ResponseError(404, "Timetable not found");
  }
  return timetable;
}
