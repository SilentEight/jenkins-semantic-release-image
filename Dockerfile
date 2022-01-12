FROM node:lts-alpine

ENV LANG=C.UTF-8 \
  NODE_ENV=production

RUN set -eux; \
  apk --update --no-cache add \
  bash \
  curl \
  git \
  git-lfs \
  openssh \
  ; \
  npm install --global npm

COPY ./package.json ./package-lock.json /semantic-release/

RUN set -eux; \
  cd /semantic-release; \
  npm ci

ENV PATH="$PATH:/semantic-release/node_modules/.bin"

USER node
WORKDIR /home/node

CMD ["semantic-release"]
