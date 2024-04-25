import { Schema, model } from "mongoose";

const messageSchema = new Schema({
  communityId: {
    type: Schema.Types.ObjectId,
    ref: "Community",
    required: true,
  },
  sender: {
    type: Schema.Types.ObjectId,
    ref: "Student",
    required: true,
  },
  message: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const MessageModel = model("Message", messageSchema);

export default MessageModel;
