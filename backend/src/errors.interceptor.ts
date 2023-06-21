import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  HttpException,
  CallHandler,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable()
export class ErrorsInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next
      .handle()
      .pipe(
        catchError((e) => throwError(() => new HttpException(e.message, 500))),
      );
  }
}
