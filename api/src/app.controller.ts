import { Controller, Get, Post, Req, Res } from '@nestjs/common';
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

  @Get('test')
  async getStream() {
    const url = new URLSearchParams();
    url.set('prompt', 'Draw a wonderful picture of a cat');
    url.set('room', 'test');

    const data = await fetch(`http://flask-service:8000/?${url.toString()}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcmVhdGVkQXQiOiIyMDI0LTAyLTA4VDE5OjE4OjE0Ljk0N1oiLCJ1cGRhdGVkQXQiOiIyMDI0LTAyLTA4VDE5OjE4OjE0Ljk0N1oiLCJpZCI6IjIyZmQyNmJkLTNjOGUtNGY5OS05NmU3LWNkNWE5ZWE0MGVjMyIsIm5hbWUiOiJ0ZXN0IiwiZW1haWwiOiJ0ZXN0QHRlc3QuY29tIiwiaWF0IjoxNzA3Njc3MDU5LCJleHAiOjE3MDc3NjM0NTl9.ue-zKHZlBpWFyadoDIGrXy4mrY7tWZKhy6pI8iGTvm8',
      },
    });
    return data.text();
  }

  @Post('image_done')
  getMessage(@Req() request: Request) {
    console.log(request.body);
    return request.body;
  }

  @Get()
  async getHello(@Res() response: Response, @Req() request: Request) {
    // response.setHeader('Content-Type', 'text/event-stream');
    // response.setHeader('Cache-Control', 'no-cache');
    // response.setHeader('Connection', 'keep-alive');
    // response.flushHeaders();
    // response.write('data: ' + 'Hello World!' + '\n\n');
    // this.subject.subscribe((data) => {
    //   response.write('data: ' + data + '\n\n');
    // });
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
