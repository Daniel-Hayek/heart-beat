module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testRegex: '.*\\.spec\\.ts$', // matches all unit test files
  moduleFileExtensions: ['ts', 'js', 'json'],
  moduleNameMapper: {
    '^src/(.*)$': '<rootDir>/src/$1', // makes Jest understand 'src/*' imports
  },
  collectCoverageFrom: [
    'src/**/*.(t|j)s',
    '!src/main.ts', // typically exclude main bootstrap
  ],
  coverageDirectory: 'coverage',
};
