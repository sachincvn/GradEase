import CommunityModel from "../models/communityModel.js";
import ResponseError from "../utils/RestResponseError.js";

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

export async function getCommunitiesByCourseYear(course, year) {
  const communities = await CommunityModel.find({ course, year }).populate(
    "members"
  );
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
