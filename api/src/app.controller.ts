import { Controller, Get, Req, Res } from '@nestjs/common';
import { Request, Response } from 'express';
import { BehaviorSubject } from 'rxjs';
import { AppService } from './app.service';

@Controller()
export class AppController {
  i = 0;
  constructor(private readonly appService: AppService) {
    setInterval(() => {
      if (this.i > 10) {
        this.subject.complete();
        return;
      }
      this.subject.next('Hello World! + ' + this.i);
      this.i++;
    }, 1000);
  }
  subject = new BehaviorSubject('Hello World!');

  @Get()
  async getHello(@Res() response: Response, @Req() request: Request) {
    const abort = new AbortController();
    request.on('close', () => {
      console.log('close');
      // abort.abort();
    });
    request.on('end', (e) => {
      console.log('readable', e);
    });
    // stream.on('end', () => response.end());
    for await (const chunk of this.generator(100)) {
      response.write(String(chunk));
      // console.log('generating', abort.signal.aborted);

      if (abort.signal.aborted) {
        return;
      }
    }
    response.end('ok');
  }

  async *generator(i) {
    while (i > 0) {
      await new Promise((resolve) => setTimeout(resolve, 100));
      i--;
      yield `i = ${i} \n`;
    }
  }
}
