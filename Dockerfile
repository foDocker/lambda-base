FROM mhart/alpine-node
COPY . /app
RUN rm -rf /app/node_modules
WORKDIR /app
ONBUILD COPY * /app/
ONBUILD RUN npm install
ONBUILD RUN npm install mongomq
CMD node index.js
