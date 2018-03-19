SRC := ./src
PUBLIC := ./public

help:
	@echo make install  npm install
	@echo make start

install:
	# install webpack
	@npm i -D webpack webpack-cli
	# install babel
	@npm i -D babel-core babel-loader babel-preset-env babel-plugin-transform-async-to-generator babel-plugin-transform-object-rest-spread babel-plugin-transform-runtime
	# install pug
	@npm i -D pug-cli
	# install eslint & prettier
	@npm i -D eslint eslint-config-prettier eslint-plugin-prettier prettier
	# install css preprocessor
	@npm i -D node-sass

start:
	@make webpack & make pug & make sass & make server

webpack:
	@npx webpack -w --mode development

pug:
	@npx pug ${SRC}/pug -wo ${PUBLIC}

sass:
	@npx node-sass ${SRC}/scss -o ${PUBLIC}/css && npx node-sass ${SRC}/scss -wo ${PUBLIC}/css

server:
	@npx browser-sync start --server ${PUBLIC}