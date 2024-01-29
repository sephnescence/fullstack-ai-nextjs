# Use the official Node.js 20 image.
# https://hub.docker.com/_/node
FROM node:20-alpine

# Create and change to the app directory.
WORKDIR /app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install

# Copy local code to the container image.
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build the application
RUN npm run build

# Run the web service on container startup.
# Opting to define command in docker-compose.yml instead so that the ports are all defined in one place
# CMD [ "npm", "run", "dev", "--", "--port", "3001" ]