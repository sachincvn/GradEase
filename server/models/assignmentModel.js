import {Schema,model} from 'mongoose';

const assignmentSchema = new Schema({
    title: {
        type: String,
        required: true,
      },
      description: {
        type: String,
        required: true,
      },
      createdDate: {
        type: Date,
        default: Date.now,
      },
      submissionDate: {
        type: Date,
        required: true,
      },
      subjectName: {
        type: String,
        required: true,
      },
});

const AssignmentModel = model("Assignment" , assignmentSchema);
export default AssignmentModel;