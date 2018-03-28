# define variable
SRC := ./src
PUBLIC := ./public
TEMP := ./tmp
DEVELOPMENT := development

.PHONY: help
help:
	@echo make install : npm install
	@echo make start : production
	@echo make start env=development : development

.PHONY: install
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
	@npm i -D node-sass postcss-cli cssnano autoprefixer
	# install watch
	@npm i -D watch

.PHONY: start
start:
	@make webpack & make pug & make sass & make postcss & make server

.PHONY: webpack
webpack:
ifeq ($(env), $(DEVELOPMENT))
	@npx webpack -w --mode development
else
	@npx webpack -w --mode production
endif

.PHONY: pug
pug:
ifeq ($(env), $(DEVELOPMENT))
	@npx pug ${SRC}/pug -Pwo ${PUBLIC}
else
	@npx pug ${SRC}/pug -wo ${PUBLIC}
endif

.PHONY: sass
sass:
	@npx node-sass ${SRC}/scss -o ${TEMP}/css && npx node-sass ${SRC}/scss -wo ${TEMP}/css

.PHONY: postcss
postcss:
	@npx postcss ${TEMP}/**/*.css -c ./postcss.config.js --no-map -b ${TEMP}/css -x css -d ${PUBLIC}/css -w

.PHONY: server
server:
	@npx browser-sync start --server ${PUBLIC}

.PHONY: eslint
eslint:
	@npx eslint --fix --ext .js ${SRC}/webpack