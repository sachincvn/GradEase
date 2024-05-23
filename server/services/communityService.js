import CommunityModel from "../models/communityModel.js";
import MessageModel from "../models/messageModel.js";
import ResponseError from "../utils/RestResponseError.js";

export const sendMessage = async (communityId, message, senderId) => {
  const newMessage = await MessageModel.create({
    communityId,
    message,
    sender: senderId,
  });
  await newMessage.populate("sender", "fullName email profileImage");
  return newMessage;
};

export const getCommunityMessages = async (
  communityId,
  page = 1,
  limit = 10
) => {
  const skip = (page - 1) * limit;

  const messages = await MessageModel.find({ communityId })
    .sort({ createdAt: -1 })
    .skip(skip)
    .limit(limit)
    .populate({ path: "sender", select: "fullName  email profileImage" })
    .exec();

  return messages;
};

export async function createCommunity(
  name,
  description,
  profileImage,
  course,
  year
) {
  const community = await CommunityModel.create({
    name,
    description,
    profileImage,
    course,
    year,
  });
  return community;
}

export async function deleteCommunity(id) {
  const response = await CommunityModel.findByIdAndDelete(id);
  return response;
}

export async function getCommunitiesByCourseYear(course, year) {
  const communities = await CommunityModel.find({ course, year }).populate({
    path: "members",
    select: "fullName email profileImage",
  });
  return communities;
}

export async function getAllCommunities() {
  const communities = await CommunityModel.find().populate({
    path: "members",
    select: "fullName email profileImage",
  });
  return communities;
}

export async function joinCommunity(communityId, userId) {
  const community = await CommunityModel.findById(communityId);

  if (!community) {
    throw new ResponseError(404, "Community not found");
  }

  if (community.members.includes(userId)) {
    return new ResponseError(404, "User already belongs to this community");
  }

  community.members.push(userId);
  await community.save();

  return community;
}
