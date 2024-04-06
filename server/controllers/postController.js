import { RestResponse, RestResponseError } from "../utils/RestResponse.js";
import {
  createPost,
  getAllPosts,
  likePost,
  dislikePost,
  getPostById,
  deletePost,
} from "../services/postService.js";

export async function CreatePostController(req, res) {
  try {
    const { title, content, authorId } = req.body;
    const post = await createPost(title, content, authorId);
    RestResponse(res, 200, null, post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetAllPostController(req, res) {
  try {
    const posts = await getAllPosts();
    RestResponse(res, 200, null, posts);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function LikePostController(req, res) {
  try {
    const { postId, userId } = req.body;
    const post = await likePost(postId, userId);
    RestResponse(res, 200, "Liked", post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DislikePostController(req, res) {
  try {
    const { postId, userId } = req.body;
    const post = await dislikePost(postId, userId);
    RestResponse(res, 200, "Disliked", post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetPostByIdController(req, res) {
  try {
    const { postId } = req.params;
    const post = await getPostById(postId);
    RestResponse(res, 200, null, post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeletePostController(req, res) {
  try {
    const { postId } = req.params;
    const post = await deletePost(postId);
    RestResponse(res, 200, "Deleted", post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
