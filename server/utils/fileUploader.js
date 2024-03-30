import multer from "multer";
import path from "path";

export function FileUploader(destination, fieldName) {
  const storage = multer.diskStorage({
    destination: destination,
    filename: (req, file, cb) => {
      cb(
        null,
        `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`
      );
    },
  });
  return multer({ storage: storage }).single(fieldName);
}
