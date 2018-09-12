.PHONY: install
install:
	# webpack
	@npm i -D webpack webpack-cli webpack-serve uglifyjs-webpack-plugin babel-loader
	# babel
	@npm i -D @babel/core @babel/plugin-syntax-object-rest-spread @babel/preset-env
	# pug
	@npm i -D pug-cli
	# eslint & prettier
	@npm i -D eslint eslint-config-prettier eslint-plugin-prettier prettier
	# css preprocessor
	@npm i -D postcss-cli cssnano autoprefixer
	# watch
	@npm i -D watch
