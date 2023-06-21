import {
  Column,
  Model,
  Table,
  ForeignKey,
  BelongsTo,
  DataType,
  Index,
} from 'sequelize-typescript';
import { Question } from './question.model';

@Table({
  timestamps: true,
  paranoid: true,
  tableName: 'answers',
})
export class Answer extends Model {
  @ForeignKey(() => Question)
  @Column
  questionId: number;

  @BelongsTo(() => Question)
  question: Question;

  @Column(DataType.TEXT)
  answer: string;

  @Index
  @Column
  username: string;
}
