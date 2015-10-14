var path = require('path');
var webpack = require('webpack');

var serverPort = 8090;
// var assetsUrl = 'http://localhost:' + serverPort + '/assets/'; // Rails 3.x
var assetsUrl = 'http://localhost:' + serverPort + '/javascripts/';  // Rails 4.x

module.exports = {
  devtool: 'eval',
  entry: [
    'webpack-dev-server/client?http://localhost:' + serverPort,
    'webpack/hot/only-dev-server',
    './app/react/react_app.js'
  ],
  output: {
    path: path.join(__dirname, '/app/assets/javascripts'),
    filename: 'react_bundle.js',
    publicPath: assetsUrl
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ],
  resolve: {
    extensions: ['', '.js', '.jsx']
  },
  module: {
    loaders: [{
      test: /\.js?$/,
      loaders: ['react-hot', 'babel'],
      include: path.join(__dirname, 'app/react/'),
      exclude: /node_modules/
    }]
  },
  serverPort: serverPort
};
