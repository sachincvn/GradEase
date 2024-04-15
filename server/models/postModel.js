import { Schema, model } from "mongoose";

const postSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  author: {
    type: Schema.Types.ObjectId,
    ref: "Student",
    required: true,
  },
  likedBy: [
    {
      type: Schema.Types.ObjectId,
      ref: "Student",
    },
  ],
  dislikedBy: [
    {
      type: Schema.Types.ObjectId,
      ref: "Student",
    },
  ],
  replies: [
    {
      content: {
        type: String,
        required: true,
      },
      author: {
        type: Schema.Types.ObjectId,
        ref: "Student",
        required: true,
      },
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const PostModel = model("Post", postSchema);

export default PostModel;
