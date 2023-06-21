import {
  Column,
  Model,
  Table,
  ForeignKey,
  BelongsTo,
} from 'sequelize-typescript';
import { Question } from './question.model';

@Table({
  timestamps: true,
  paranoid: true,
  tableName: 'questionTestCases',
})
export class QuestionTestCase extends Model {
  @ForeignKey(() => Question)
  @Column
  questionId: number;

  @BelongsTo(() => Question)
  question: Question;

  @Column
  code: string;
}
