import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/sequelize';
import { Sequelize } from 'sequelize-typescript';
import { Question } from './models/question.model';
import axios from 'axios';
import { Answer } from './models/answer.model';

@Injectable()
export class AppService {
  constructor(
    private sequelize: Sequelize,
    @InjectModel(Question)
    private questionModel: typeof Question,
    @InjectModel(Answer)
    private answerModel: typeof Answer,
  ) {}

  async getQuestions() {
    return this.questionModel.findAll({ include: ['testCases'] });
  }

  async saveAnswer(username, questionId, answer) {
    const instance = await this.answerModel.findOne({
      where: {
        username,
        questionId,
      },
    });

    if (instance) {
      instance.answer = answer;
      await instance.save();
    } else {
      await this.answerModel.create({
        questionId,
        username,
        answer,
      });
    }
  }

  getWebSocketToken() {
    return axios.post('https://api.jdoodle.com/v1/auth-token', {
      clientId: process.env.JDOODLE_CLIENT_ID,
      clientSecret: process.env.JDOODLE_CLIENT_SECRET,
    });
  }

  postExecute(script: string, language: string, versionIndex: string) {
    return axios.post('https://api.jdoodle.com/v1/execute', {
      script,
      language,
      versionIndex,
      clientId: process.env.JDOODLE_CLIENT_ID,
      clientSecret: process.env.JDOODLE_CLIENT_SECRET,
    });
  }

  getAnswers(username: string) {
    return this.answerModel.findAll({
      where: { username },
      include: [{ model: Question, include: ['testCases'] }],
    });
  }
}
