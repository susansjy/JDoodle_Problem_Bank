import { Column, Model, Table, HasMany, DataType } from 'sequelize-typescript';
import { QuestionTestCase } from './questionTestCases.model';

@Table({
  timestamps: true,
  paranoid: true,
  tableName: 'questions',
})
export class Question extends Model {
  @Column
  functionName: string;

  @Column(DataType.TEXT)
  detail: string;

  @Column
  placeholder: string;

  @HasMany(() => QuestionTestCase, {
    onDelete: 'RESTRICT',
    onUpdate: 'RESTRICT',
  })
  testCases: QuestionTestCase[];
}
