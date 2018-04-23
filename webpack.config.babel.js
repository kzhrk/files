import webpack from 'webpack';
import path from 'path';

export default {
  entry: {
    main: './src/webpack/main.js'
  },

  output: {
    path: path.resolve(__dirname, './public/js'),
    filename: '[name].bundle.js'
  },

  resolve: {
    extensions: ['.js']
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          {
            loader: 'babel-loader'
          }
        ]
      }
    ]
  },

  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('production')
      }
    })
  ],

  devServer: {
    contentBase: path.join(__dirname, 'public'),
    compress: true,
    port: 3000
  }
};
