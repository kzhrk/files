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
	# webpack
	@npm i -D webpack webpack-cli webpack-dev-server
	# babel
	@npm i -D babel-core babel-loader babel-preset-env
	# pug
	@npm i -D pug-cli
	# eslint & prettier
	@npm i -D eslint eslint-config-prettier eslint-plugin-prettier prettier
	# css preprocessor
	@npm i -D postcss-cli cssnano autoprefixer
	# watch
	@npm i -D watch
	# git hooks
	@npm i -D git-hooks
	@mkdir -p .githooks/pre-commit
	@echo '#!/bin/bash' "\nmake eslint" > .githooks/pre-commit/eslint
	@chmod +x .githooks/pre-commit/eslint
	# watch
	@npm i -D watch

.PHONY: start
start:
	@make webpack & make pug & make postcss & make watch & make server

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

.PHONY: watch
watch:
	@npx watch "make postcss" ${SRC}/css --interval=15

.PHONY: postcss
postcss:
	@npx postcss ${SRC}/css/*.css -c ./postcss.config.js --no-map -b ${SRC}/css -x css -d ${PUBLIC}/css

.PHONY: server
server:
	@webpack-dev-server

.PHONY: eslint
eslint:
	@npx eslint --fix --ext .js ${SRC}/webpack ./webpack.config.babel.js