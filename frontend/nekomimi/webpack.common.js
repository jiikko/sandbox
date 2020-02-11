const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCSSEXtractPlugin = require('mini-css-extract-plugin');

const src = path.join(__dirname, 'src');

module.exports = {
  entry: path.resolve(src, 'js/render.jsx'),
  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      { test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      { test: /\.css$/,
        exclude: /node_modules/,
        use: [
          MiniCSSEXtractPlugin.loader,
          { loader: 'css-loader',
            options: {
              importLoaders: 1,
              modules: {
                localIdentName: '[name__[local]--[hash:base64:5]'
              }
            }
          },
          'postcss-loader'
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.resolve(src, 'html/index.html')
    }),
    new MiniCSSEXtractPlugin({
      filename: 'app.css',
    }),
  ]
}
