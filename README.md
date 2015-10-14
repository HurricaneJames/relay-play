Playing around with relay. Not really useful for anything.

Note: I really need to stop watching Disney fairy movies with my daughter...

## Getting Starting
````
# setup
bundle install
npm install

# Backend
rails s

# Front-end compilation
npm start

# GraphiQL interface
open http://localhost:3000/graphiql

# Demo Application (in dev mode this has hot reloading)
open http://localhost:3000

# every time you update the schema...
# kill both servers then run
npm run updateSchema
rails s
npm start
# looking for a better way to handle this (especially the updateSchema part)
````


## Notes
Production asset compilation is normally accomplised with a custom rake task (rake assets:build). This task production compiles the react components then combines that with the Rails asset pipeline. If you can avoid using the asset pipeline completely, I suggest doing so, but since I got this working in another project I find I use it more than I should.

Unfortunately, it is probably broken in this repo. `webpack.production.config.js` was not enhanced to work with Relay (and the slightly annoying Relqy.QL schema requirements). So, use it at your own risk.