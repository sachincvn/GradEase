import {
  createCommunity,
  getCommunitiesByCourseYear,
  getCommunityMessages,
  joinCommunity,
  sendMessage,
} from "../services/communityService.js";
import { RestResponse, RestResponseError } from "../utils/RestResponse.js";

import { getSocketInstance } from "../socket.js";

export const sendMessageController = async (req, res) => {
  try {
    const { communityId, message, senderId } = req.body;

    const newMessage = await sendMessage(communityId, message, senderId);

    const io = getSocketInstance();
    io.to(communityId).emit("newMessage", { message: newMessage });

    return RestResponse(res, 200, null, newMessage);
  } catch (error) {
    return RestResponseError(res, error);
  }
};

export const getCommunityMessagesController = async (req, res) => {
  try {
    const { communityId } = req.params;
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    const messages = await getCommunityMessages(communityId, page, pageSize);
    return RestResponse(res, 200, "Messages retrieved successfully", messages);
  } catch (error) {
    return RestResponseError(res, error);
  }
};

export const createCommunityController = async (req, res) => {
  try {
    const { name, description, profileImage, course, year } = req.body;
    const community = await createCommunity(
      name,
      description,
      profileImage,
      course,
      year
    );
    return RestResponse(res, 200, "Community created successfully", community);
  } catch (error) {
    return RestResponseError(res, error);
  }
};

export const getCommunitiesByCourseYearController = async (req, res) => {
  try {
    const { course, year } = req.params;
    const communities = await getCommunitiesByCourseYear(course, year);
    return RestResponse(res, 200, null, communities);
  } catch (error) {
    return RestResponseError(res, error);
  }
};

export const joinCommunityController = async (req, res) => {
  try {
    const { communityId, userId } = req.body;
    const community = await joinCommunity(communityId, userId);
    if (community) {
      return RestResponse(res, 200, "Joined successfully", true);
    }
    return RestResponse(res, 400, "Failed to join", false);
  } catch (error) {
    return RestResponseError(res, error);
  }
};

//community controller
