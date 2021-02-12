const io = require("socket.io")(4000);

let count = 0;
setInterval(() => {
  io.emit("msg", count);
  count += 1;
}, 10000);
