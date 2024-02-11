import { INestApplication } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { io, type Socket as ClientSocket } from 'socket.io-client';
import { UserEntity } from 'src/entities/user.entity';
import { MessagesGateway } from 'src/messages/messages.gateway';
import { MockUsers } from 'src/test_utils/constants';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';

const signupQuery = `mutation signUp($email: String!, $password: String!, $name: String!) {
  signUp(data: {email:$email, password: $password, name:$name}) {
        token,
        user {
            email,
            id,
            name
        }
    }
}
`;

const signInQuery = `mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
        token,
        user {
            email,
            id,
            name
        }
    }
}
`;

async function clearDatabase(app: INestApplication): Promise<void> {
  // const entityManager = app.get<EntityManager>(EntityManager);
  // const tableNames = entityManager.connection.entityMetadatas.map(
  //   (entity) => entity.tableName,
  // );
  // for await (const tableName of tableNames) {
  //   await entityManager.query(
  //     `
  //       BEGIN;
  //       ALTER TABLE ${tableName} DISABLE TRIGGER ALL;
  //       TRUNCATE TABLE ${tableName};
  //       ALTER TABLE ${tableName} ENABLE TRIGGER ALL;
  //       COMMIT;
  //     `,
  //   );
  // }
}

function waitFor(socket, event: string) {
  return new Promise((resolve) => {
    socket.once(event, resolve);
  });
}

describe('GraphQl, Testing User functionalities', () => {
  let app: INestApplication;
  let clientSocket: ClientSocket;
  let messageGateway: MessagesGateway;
  let token: string;

  afterAll(async () => {
    await clientSocket.disconnect();
    await app?.close();
  });

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();

    const repo = app.get(getRepositoryToken(UserEntity));
    await repo.delete({});

    const testUser = MockUsers[0];
    const user = await request(app.getHttpServer()).post('/graphql').send({
      query: signupQuery,
      variables: testUser,
    });
    token = user.body.data.signUp.token;
  });

  it('/Web socket a user can connect to websocket', async () => {
    console.log(token);

    const socket = io(`http://localhost`, {
      extraHeaders: {
        authorization: `Bearer ${token}`,
      },
    });

    const val = await waitFor(socket, 'connect');
    console.log('val', val);
    expect(val).toBeDefined();
  });
});
