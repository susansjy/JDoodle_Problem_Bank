import {
  Controller,
  Get,
  Post,
  Bind,
  Body,
  Param,
  UseInterceptors,
} from '@nestjs/common';
import { shuffle } from 'lodash';
import { AppService } from './app.service';
import { TransformInterceptor } from './transform.interceptor';
import { ErrorsInterceptor } from './errors.interceptor';

@UseInterceptors(new TransformInterceptor())
@UseInterceptors(new ErrorsInterceptor())
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('fiveQuestions')
  async getFiveQuestions() {
    const questions = await this.appService.getQuestions();
    return shuffle(questions).slice(0, 5);
  }

  @Get('websocketToken')
  async getWebSocketToken() {
    const { data } = await this.appService.getWebSocketToken();

    return { token: data };
  }

  @Post('nodeJSExecuteAndSaveAnswer')
  @Bind(Body())
  async nodeJSExecuteAndSaveAnswer({ script, username, questionId, answer }) {
    await this.appService.saveAnswer(username, questionId, answer);
    const { data } = await this.appService.postExecute(script, 'nodejs', '4');

    return { result: data.output };
  }

  @Get('answer/:username')
  async getAnswer(@Param('username') username: string) {
    const answers = await this.appService.getAnswers(username);

    return answers;
  }

  @Post('nodeJSExecute')
  @Bind(Body())
  async nodeJSExecute({ script }) {
    const { data } = await this.appService.postExecute(script, 'nodejs', '4');

    return { result: data.output };
  }
}
