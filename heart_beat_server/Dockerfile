# Use Node.js official image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install bash so wait-for-it.sh works
RUN apk add --no-cache bash

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (including nodemon)
RUN npm install

# Copy source code
COPY . .

# Expose port 3000
EXPOSE 3000

# Default command
CMD ["npm", "run", "start:dev"]