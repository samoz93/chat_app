import { io, Socket } from 'socket.io-client';
import { IoMessageEnterOrExit, ServerToClientTypes } from 'src/types';

const toPromise = <T>(
  event: keyof ServerToClientTypes | 'connect' | 'disconnect',
  client,
): Promise<{
  event: string;
  data: T;
}> => {
  return new Promise((resolve) => {
    client.once(event, (data) => {
      resolve({
        event,
        data,
      });
    });
  });
};

describe('MessagesGateway', () => {
  let client: Socket<any, any>;
  beforeEach(async () => {
    client = io('http://localhost');
  });

  it('Should be able to connect', async () => {
    try {
      const data = await toPromise('connect', client);
      console.log(data);
    } catch (error) {
      console.log(error);
    }
  });

  it('Should be able to join a room and get a roomEvent message', async () => {
    client.emit('join', 'room1');

    // const data = await toPromise('newMessage', client);

    const data = await toPromise<IoMessageEnterOrExit>('roomEvents', client);

    expect(data).toBeDefined();
    expect(data.data.room).toBe('room1');
    expect(data.data.type).toBe('join');
  });

  it('Should be able to receive leaving Message', (done) => {
    const client2 = io('http://localhost');
    client2.emit('join', 'room1');
    client.emit('join', 'room1');
    const onRoomEvents = (data) => {
      if (data.type === 'leave') {
        expect(data).toBeDefined();
        expect(data.room).toBe('room1');
        expect(data.type).toBe('leave');
        socket.off('roomEvents', onRoomEvents);
        done();
      }
    };
    const socket = client.on('roomEvents', onRoomEvents);
    client2.emit('leave', 'room1');
  }, 10000);

  it('Multiple user can join and will get notified about other people joining in', (done) => {
    const client2 = io('http://localhost');
    client2.emit('join', 'room1');

    client2.once('newMessage', (data) => {
      expect(data).toBeDefined();
      done();
    });

    client.emit('join', 'room1');
  });

  it('Multiple users can join and will get notified about other people leaving in', (done) => {
    const client2 = io('http://localhost');
    client2.emit('join', 'room1');
    client2.once('newMessage', (data) => {
      expect(data).toBeDefined();
      done();
    });

    client.emit('join', 'room1');
  });

  it('Sending message to a room', (done) => {
    const client2 = io('http://localhost');
    client2.once('newMessage', (data) => {
      expect(data).toBeDefined();
      done();
    });

    client2.emit('join', 'room1');
    client.emit('join', 'room1');
    client.emit('message', {
      message: 'Hello World',
      room: 'room1',
      sender: '123',
      receiver: 'room1',
    });
  }, 20000);
});
