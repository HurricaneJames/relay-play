Rails.application.routes.draw do
  match 'graphql', to: 'graphql#exec', via: [:get, :post]
  root to: 'graphql#graphiql'
end
