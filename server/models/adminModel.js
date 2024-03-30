import { Schema, model } from "mongoose";

const adminSchema = new Schema({
  fullName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
});

const AdminModel = model("Admin", adminSchema);

export default AdminModel;
