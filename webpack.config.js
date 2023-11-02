const webpack = require('webpack');

module.exports = {
  plugins: [
    new webpack.DefinePlugin({
      'process.env.PAYJP_PUBLIC_KEY': JSON.stringify(process.env.PAYJP_PUBLIC_KEY)
    })
  ]
};