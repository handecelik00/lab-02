FROM node:20-alpine

WORKDIR /app

RUN echo "AZURE_CLIENT_SECRET=my-super-secret-abc123" > /tmp/dev.env
RUN rm /tmp/dev.env

COPY src/ ./src/
COPY package*.json ./

RUN npm ci --only=production

CMD ["node", "src/index.js"]