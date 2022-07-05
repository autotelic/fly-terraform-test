FROM node:lts-alpine
WORKDIR /code
ENV FASTIFY_ADDRESS=0.0.0.0
RUN npm install yarn
COPY package.json package.json
RUN yarn install
EXPOSE 3000
COPY . .
CMD ["yarn", "run", "dev"]
