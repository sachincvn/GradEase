import { RestResponse, RestResponseError } from "../utils/RestResponse.js";
import {
  createPost,
  getAllPosts,
  likePost,
  dislikePost,
  getPostById,
  deletePost,
  addReply,
  deleteReply,
  getRepliesForPost,
} from "../services/postService.js";

export async function CreatePostController(req, res) {
  try {
    const { title, content, authorId } = req.body;
    const post = await createPost(title, content, authorId);
    return RestResponse(res, 200, null, post._id);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetAllPostController(req, res) {
  try {
    const { page, pageSize } = req.query;
    const pageNumber = parseInt(page, 10) || 1;
    const pageSizeNumber = parseInt(pageSize, 10) || 10;
    const posts = await getAllPosts(pageNumber, pageSizeNumber);
    return RestResponse(res, 200, null, posts);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
export async function LikePostController(req, res) {
  try {
    const { postId, userId } = req.body;
    const post = await likePost(postId, userId);
    return RestResponse(res, 200, "Liked", post._id);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DislikePostController(req, res) {
  try {
    const { postId, userId } = req.body;
    const post = await dislikePost(postId, userId);
    return RestResponse(res, 200, "Disliked", post._id);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetPostByIdController(req, res) {
  try {
    const { postId } = req.params;
    const post = await getPostById(postId);
    return RestResponse(res, 200, null, post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeletePostController(req, res) {
  try {
    const { postId } = req.params;
    const post = await deletePost(postId);
    return RestResponse(res, 200, "Deleted", post._id);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function AddReplyController(req, res) {
  try {
    const { postId } = req.params;
    const { content, authorId } = req.body;
    const post = await addReply(postId, content, authorId);
    return RestResponse(res, 200, null, post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function DeleteReplyController(req, res) {
  try {
    const { postId, replyId } = req.params;
    const post = await deleteReply(postId, replyId);
    return RestResponse(res, 200, "Reply deleted successfully", post);
  } catch (error) {
    return RestResponseError(res, error);
  }
}

export async function GetRepliesForPostController(req, res) {
  try {
    const { postId } = req.params;
    const replies = await getRepliesForPost(postId);
    return RestResponse(res, 200, null, replies);
  } catch (error) {
    return RestResponseError(res, error);
  }
}
