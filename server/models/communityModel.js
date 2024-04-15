import { Schema, model } from "mongoose";

const communitySchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  profileImage: {
    type: String,
    required: false,
  },
  course: {
    type: String,
    required: true,
  },
  year: {
    type: Number,
    required: true,
  },
  members: [
    {
      type: Schema.Types.ObjectId,
      ref: "Student",
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const CommunityModel = model("Community", communitySchema);
export default CommunityModel;
