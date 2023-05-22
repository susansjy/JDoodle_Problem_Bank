import { Controller, Dependencies, Get, Post, Bind, Body, HttpException } from '@nestjs/common';
import { shuffle, pick } from 'lodash';
import { AppService } from './app.service';
import questions from "../questions.json";

@Controller()
@Dependencies(AppService)
export class AppController {
  constructor(appService) {
    this.appService = appService;
  }

  @Get("fiveQuestions") 
  getFiveQuestions() {
    return shuffle(questions).slice(0, 5);
  }

  @Get("websocketToken")
  async getWebSocketToken() {
    try {
      const { data } = await this.appService.getWebSocketToken();

      return { token: data };
    } catch (e) {
      throw new HttpException('Server Error', 500);
    }
  }

  @Post("nodeJSExecute")
  @Bind(Body())
  async nodeJSExecute({ script }) {
    try {
      const { data } = await this.appService.postExecute(script, "nodejs", "4");

      return { result: data.output };
    } catch (e) {
      throw new HttpException('Server Error', 500);
    }
  }
}
