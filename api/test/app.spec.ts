import { INestApplication } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { MockUsers } from 'src/test_utils/constants';
import * as request from 'supertest';
import { Repository } from 'typeorm';
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

console.log('CONFIG', CONFIG);

describe('GraphQl, Testing User functionalities', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
    const db = app.get<Repository<UserEntity>>(getRepositoryToken(UserEntity));
    db.clear();
  });

  it('/graphql A user can sign up for an account', () => {
    const testUser = MockUsers[0];
    return request(app.getHttpServer())
      .post('/graphql')
      .send({
        query: signupQuery,
        variables: testUser,
      })
      .expect(200)
      .expect((res) => {
        expect(res.body.data.signUp.user.email).toEqual(testUser.email);
        expect(res.body.data.signUp.user.name).toEqual(testUser.name);
        expect(res.body.data.signUp.user.id).toBeDefined();
        expect(res.body.data.signUp.token).toBeDefined();
      });
  });

  it('/graphql A user can sign in ', async () => {
    const testUser = MockUsers[0];
    await request(app.getHttpServer())
      .post('/graphql')
      .send({
        query: signupQuery,
        variables: testUser,
      })
      .expect(200);

    return request(app.getHttpServer())
      .post('/graphql')
      .send({
        query: signInQuery,
        variables: testUser,
      })
      .expect(200)
      .expect((res) => {
        expect(res.body.data.login.user.email).toEqual(testUser.email);
        expect(res.body.data.login.user.name).toEqual(testUser.name);
        expect(res.body.data.login.user.id).toBeDefined();
        expect(res.body.data.login.token).toBeDefined();
      });
  });

  it('/graphql Signup process is uniq (no duplicate emails)', async () => {
    const testUser = MockUsers[0];
    await request(app.getHttpServer())
      .post('/graphql')
      .send({
        query: signupQuery,
        variables: testUser,
      })
      .expect(200);

    await request(app.getHttpServer())
      .post('/graphql')
      .send({
        query: signupQuery,
        variables: testUser,
      })
      .expect(200)
      .expect((res) => {
        expect(res.body.errors[0].message).toEqual('User already exists');
        expect(res.body.data).toBeNull();
      });
  });
});
