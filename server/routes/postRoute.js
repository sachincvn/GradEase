import { Router } from "express";
import {
  CreatePostController,
  GetAllPostController,
  LikePostController,
  DislikePostController,
  GetPostByIdController,
  DeletePostController,
} from "../controllers/postController.js";

const postRoute = Router();

postRoute.post("/", CreatePostController);
postRoute.get("/", GetAllPostController);
postRoute.post("/like", LikePostController);
postRoute.post("/dislike", DislikePostController);
postRoute.get("/:postId", GetPostByIdController);
postRoute.delete("/:postId", DeletePostController);

export default postRoute;
