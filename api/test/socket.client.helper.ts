import { INestApplication } from '@nestjs/common';
import { io } from 'socket.io-client';

export const getClientWebsocketForAppAndNamespace = (
  app: INestApplication,
  query?: object,
) => {
  const httpServer = app.getHttpServer();
  if (!httpServer.address()) {
    httpServer.listen(0);
  }

  console.log('httpServer.address()', httpServer.address());

  return io(`http:localhost:3000`, {
    query,
  });
};
