import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AppModule } from './app.module';
import { SequelizeModule } from '@nestjs/sequelize';
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { Question } from './models/question.model';
import { QuestionTestCase } from './models/questionTestCases.model';
import { Answer } from './models/answer.model';

describe('AppController', () => {
  let appController: AppController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
      imports:[
        ConfigModule.forRoot(),
        SequelizeModule.forRoot({
          dialect: 'mysql',
          host: process.env.MYSQL_HOST,
          port: parseInt(process.env.MYSQL_PORT),
          username: process.env.MYSQL_USERNAME,
          password: process.env.MYSQL_PASSWORD,
          database: process.env.MYSQL_DATABASE,
          models: [Question, QuestionTestCase, Answer],
        }),
        SequelizeModule.forFeature([Question, Answer]),
      ]
    }).compile();

    appController = app.get<AppController>(AppController);
  });

  describe('fiveQuestions', () => {
    it('should return an array with length 5', async () => {
      const result = await appController.getFiveQuestions();
      expect(result.length).toBe(5);
    });
  });
});

