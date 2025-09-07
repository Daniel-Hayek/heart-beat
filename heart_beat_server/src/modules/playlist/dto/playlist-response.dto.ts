import { Expose, Type } from 'class-transformer';

export class UserSummaryDto {
  @Expose()
  id: number;

  @Expose()
  email: string;
}

export class PlaylistResponseDto {
  @Expose()
  id: number;

  @Expose()
  name: string;

  @Expose()
  description?: string;

  @Expose()
  @Type(() => UserSummaryDto)
  user: UserSummaryDto;
}
