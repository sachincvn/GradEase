import multer from "multer";
import path from "path";

export function FileUploader(destination, fieldName) {
  const storage = multer.diskStorage({
    destination: destination,
    filename: (req, file, cb) => {
      const fileExtension = path.extname(file.originalname);
      const uniqueFilename = `${
        file.originalname
      }_${Date.now()}${fileExtension}`;
      cb(null, uniqueFilename);
    },
  });
  return multer({ storage: storage }).single(fieldName);
}
