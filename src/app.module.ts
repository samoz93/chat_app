import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { TypeOrmModule } from '@nestjs/typeorm';
import { join } from 'path';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CONFIG } from './config';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'db',
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
      typePaths: ['./**/*.graphql'],
      definitions: {
        path: join(process.cwd(), 'src/schema/graphql.ts'),
      },
      playground: true,
    }),
    UserModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
