import {
  createTimetable,
  deleteTimetable,
  getAllTimetable,
  getTimetable,
  updateTimetable,
} from "../services/timeTableService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

export async function GetTimeTableController(req, res) {
  try {
    const { course, year, section } = req.params;
    const response = await getTimetable(course, parseInt(year), section);
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetAllTimeTableController(req, res) {
  try {
    const response = await getAllTimetable();
    return RestResponse(res, 200, null, response);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function CreateTimeTableController(req, res) {
  try {
    const { course, year, section, timetableData } = req.body;
    const timetable = await createTimetable(
      course,
      parseInt(year),
      section,
      timetableData
    );
    return RestResponse(res, 200, null, timetable);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function UpdateTimeTableController(req, res) {
  try {
    const { course, year, section } = req.params;
    const updatedTimetableData = req.body.timetableData;
    const timetable = await updateTimetable(
      course,
      parseInt(year),
      section,
      updatedTimetableData
    );
    return RestResponse(res, 200, null, timetable);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeleteTimeTableController(req, res) {
  const { course, year, section } = req.params;
  try {
    const timetable = await deleteTimetable(course, parseInt(year), section);
    return RestResponse(res, 200, null, timetable);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
