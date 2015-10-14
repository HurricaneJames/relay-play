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
