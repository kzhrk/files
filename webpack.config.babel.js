import webpack from 'webpack';
import path from 'path';

export default {
  entry: {
    main: './src/webpack/main.js'
  },

  output: {
    path: path.resolve(__dirname, './public/js'),
    filename: '[name].js'
  },

  resolve: {
    extensions: ['.js']
  },

  // optimization: {
  //   splitChunks: {
  //     name: 'vendors',
  //     chunks: 'initial'
  //   }
  // },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
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
  },

  devtool: process.env.NODE_ENV === 'production' ? '' : 'inline-source-map',

  mode: process.env.NODE_ENV
};
