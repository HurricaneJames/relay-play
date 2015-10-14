Rails.application.routes.draw do
  match 'graphql', to: 'graphql#exec', via: [:get, :post]
  match 'graphiql', to: 'graphql#graphiql', via: [:get, :post]
  root to: 'demo#fairies'
end
