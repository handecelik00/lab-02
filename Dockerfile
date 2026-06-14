FROM node:22-alpine AS deps

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

FROM node:22-alpine AS test

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm test

FROM node:22-alpine AS production

WORKDIR /app

RUN addgroup -g 3000 appgroup && adduser -S appuser -u 3000 -G appgroup

COPY --from=deps /app/node_modules ./node_modules
COPY src ./src
COPY package*.json ./

USER appuser

EXPOSE 3000

ENV NODE_ENV=production

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
CMD wget -qO- http://localhost:3000/health || exit 1

CMD ["node", "src/index.js"]