import PostModel from "../models/postModel.js";
import ResponseError from "../utils/RestResponseError.js";

export async function createPost(title, content, authorId) {
  const newPost = new PostModel({
    title,
    content,
    author: authorId,
  });

  const savedPost = await newPost.save();
  return savedPost;
}

export async function getAllPosts() {
  const posts = await PostModel.find()
    .populate("author", "fullName email profileImage")
    .populate("likedBy", "fullName email profileImage")
    .populate("dislikedBy", "fullName email profileImage");
  return posts;
}

export async function likePost(postId, userId) {
  const post = await PostModel.findById(postId);
  if (!post) {
    throw new Error("Post not found");
  }

  const likedIndex = post.likedBy.indexOf(userId);
  const dislikedIndex = post.dislikedBy.indexOf(userId);

  if (dislikedIndex !== -1) {
    post.dislikedBy.splice(dislikedIndex, 1);
  }

  if (likedIndex === -1) {
    post.likedBy.push(userId);
  }

  await post.save();
  return post;
}

export async function dislikePost(postId, userId) {
  const post = await PostModel.findById(postId);
  if (!post) {
    throw new Error("Post not found");
  }

  const likedIndex = post.likedBy.indexOf(userId);
  if (likedIndex !== -1) {
    post.likedBy.splice(likedIndex, 1);
  }

  if (!post.dislikedBy.includes(userId)) {
    post.dislikedBy.push(userId);
  }

  await post.save();
  return post;
}

export async function getPostById(postId) {
  const post = await PostModel.findById(postId)
    .populate("author", "fullName email profileImage")
    .populate("likedBy", "fullName email profileImage")
    .populate("dislikedBy", "fullName email profileImage");
  if (!post) {
    throw new ResponseError(404, "Post not found");
  }
  return post;
}

export async function deletePost(postId) {
  const post = await PostModel.findByIdAndDelete(postId);
  if (!post) {
    throw new ResponseError(404, "Post not found");
  }
  return post;
}
