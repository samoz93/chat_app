import { NestFactory } from '@nestjs/core';
import * as cookieParser from 'cookie-parser';
import helmet from 'helmet';
import { AppModule } from './app.module';
import { CONFIG } from './config';
async function bootstrap() {
  console.log('CONFIG', CONFIG);

  const app = await NestFactory.create(AppModule, {});
  app.use(cookieParser(CONFIG.cookieSecret));
  app.enableCors({
    origin: CONFIG.isDev ? '*' : 'localhost:3000',
  });
  app.use(helmet());
  // app.use(
  //   helmet({
  //     crossOriginEmbedderPolicy: false,
  //     contentSecurityPolicy: {
  //       directives: {
  //         imgSrc: [
  //           `'self'`,
  //           'data:',
  //            'apollo-server-landing-page.cdn.apollographql.com',
  //         ],
  //         scriptSrc: [`'self'`, `https: 'unsafe-inline'`],
  //         manifestSrc: [
  //           `'self'`,
  //           'apollo-server-landing-page.cdn.apollographql.com',
  //         ],
  //         frameSrc: [`'self'`, 'sandbox.embed.apollographql.com'],
  //       },
  //     },
  //   }),
  // );
  // app.connectMicroservice({
  //   options: {
  //     urls: ['amqp://rabbitmq-srv:5672'],
  //   },
  // });
  await app.listen(3000);
}
bootstrap();
