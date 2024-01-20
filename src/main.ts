import { NestFactory } from '@nestjs/core';
// import * as cors from 'cors';
// import * as helmet from 'helmet';
import { AppModule } from './app.module';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  // app.use(cors);
  // app.use(helmet);
  await app.listen(3000);
}
bootstrap();
