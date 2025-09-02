import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import {
  SWAGGER_CUSTOM_CSS,
  swaggerDarkModeMiddleware,
} from '@debiprasadmishra50/swagger-dark-mode';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  const config = new DocumentBuilder()
    .setTitle('Heart-Beat APIs')
    .setDescription(
      'API Documentation for all available APIs on the Heart-Beat applcation',
    )
    .setVersion('1.0')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);

  app.use('/docs', swaggerDarkModeMiddleware);

  SwaggerModule.setup('docs', app, document, {
    customCss: SWAGGER_CUSTOM_CSS,
  });

  await app.listen(process.env.PORT ?? 3000);
}

bootstrap().catch((e) => {
  console.error('Failed to start server: ', e);
});
