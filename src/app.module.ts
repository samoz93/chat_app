import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { TypeOrmModule } from '@nestjs/typeorm';
import { join } from 'path';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { CONFIG } from './config';
import { MessagesGateway } from './messages/messages.gateway';
import { MessagesModule } from './messages/messages.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: CONFIG.dbHost,
      port: CONFIG.dbPort,
      database: CONFIG.dbDatabase,
      username: CONFIG.dbUserName,
      password: CONFIG.dbPassword,
      synchronize: CONFIG.isDev,
      entities: [join(__dirname, 'entities', '*.entity.{ts,js}')],
    }),
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      subscriptions: {
        'graphql-ws': true,
      },
      formatError: (err) => {
        return {
          message: err.message,
          path: err.path,
        };
      },
      // context: ({ req, res }) => ({ req, res }),
      typePaths: ['./**/*.graphql'],
      definitions: {
        path: join(process.cwd(), 'src/schema/graphql.ts'),
      },
      playground: {
        settings: {
          'request.credentials': 'include',
        },
      },
    }),
    UserModule,
    AuthModule,
    MessagesModule,
  ],
  controllers: [AppController],
  providers: [AppService, MessagesGateway],
})
export class AppModule {}
