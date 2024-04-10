import { Router } from "express";
import {
    CreatePostController,
    GetAllPostController,
    LikePostController,
    DislikePostController,
    GetPostByIdController,
    DeletePostController,
    AddReplyController,
    DeleteReplyController,
    GetRepliesForPostController,
} from "../controllers/postController.js";

hhelo
const postRoute = Router();

postRoute.post("/", CreatePostController);
postRoute.get("/", GetAllPostController);
postRoute.post("/like", LikePostController);
postRoute.post("/dislike", DislikePostController);
postRoute.get("/:postId", GetPostByIdController);
postRoute.delete("/:postId", DeletePostController);
postRoute.post("/:postId/replies", AddReplyController);
postRoute.delete("/:postId/replies/:replyId", DeleteReplyController);
postRoute.get("/:postId/replies", GetRepliesForPostController);

export default postRoute;