import { Schema, model } from "mongoose";

const feedbackSchema = new Schema(
  {
    user: {
      name: {
        type: String,
        required: true,
      },
      email: {
        type: String,
        required: true,
        match: [/.+\@.+\..+/, "Please enter a valid email address"], // this is for email formata
      },
    },
    description: {
      type: String,
      required: false,
    },
    submittedDate: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true }
); // it will add createdAt and updatedAt fields automatically

const FeedbackModel = model("Feedback", feedbackSchema);

export default FeedbackModel;
