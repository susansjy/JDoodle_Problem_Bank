import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { SequelizeModule } from '@nestjs/sequelize';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { Question } from './models/question.model';
import { QuestionTestCase } from './models/questionTestCases.model';
import { Answer } from './models/answer.model';

@Module({
  imports: [
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
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
