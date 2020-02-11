const path = require('path');

const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCSSEXtractPlugin = require('mini-css-extract-plugin');

const src = path.join(__dirname, 'src');
const dist = path.join(__dirname, 'dist');

module.exports = {
  mode: 'development',
  entry: path.resolve(src, 'js/render.jsx'),
  output: {
    filename: 'index.bundle.js',
    path: dist
  },
  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      { test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        enforce: 'pre',
        loader: 'eslint-loader'
      },
      { test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      { test: /\.css$/,
        exclude: /node_modules/,
        use: [MiniCSSEXtractPlugin.loader, 'css-loader']
      }
    ]
  },
  devServer: {
    contentBase: dist,
    hot: true,
    port: 3000
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      template: path.resolve(src, 'html/index.html')
    }),
    new MiniCSSEXtractPlugin({
      filename: 'app.css',
    })
  ]
}
