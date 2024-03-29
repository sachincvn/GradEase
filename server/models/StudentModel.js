const mongoose = require('mongoose');

const GenderEnum = ['Male', 'Female', 'Other'];
const CourseEnum = ['MCA', 'MBA'];

const studentSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: true
    },
    fatherName: {
        type: String,
        required: true
    },
    dob: {
        type: Date,
        required: true
    },
    gender: {
        type: String,
        enum: GenderEnum,
        required: true
    },
    course: {
        type: String,
        enum: CourseEnum,
        required: true
    },
    courseYear: {
        type: Number,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    studentPhone: {
        type: String,
        required: true
    },
    parentPhone: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    }
});

const StudentModel = mongoose.model('Student', studentSchema);

module.exports = StudentModel;
