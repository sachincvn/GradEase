import { Server } from "socket.io";

let io;

const initializeSocket = (server) => {
  io = new Server(server);

  io.on("connection", (socket) => {
    socket.on("joinCommunity", (communityId) => {
      socket.join(communityId);
    });

    socket.on("chatMessage", (data) => {
      io.to(data.communityId).emit("newMessage", { message: data });
    });
  });
};

const getSocketInstance = () => {
  if (!io) {
    throw new Error("Socket.io has not been initialized");
  }
  return io;
};

export { initializeSocket, getSocketInstance };
