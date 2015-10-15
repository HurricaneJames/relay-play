# Making Relay Work

Relay is, at least initially, an unpleasant experience. A few weeks ago I read a blog post by Albert Still that said to "Give [Relay] 5 days," [link](http://red-badger.com/blog/2015/08/28/give-it-5-days-facebook-relay-and-graphql/). Some back of the napkin math, assuming 8 hour days, would mean Relay requires roughly 480x the amount of effort it took to grasp the core parts of React. After the last few days, I think that is pretty accurate. However, I do not believe it has to be quite that bad.

I believe a lot of the confusion comes from the fact that Relay is actually doing a couple of different things, and those things are not well separated in the docs and tutorials. Also, the documentation and tutorials start out trying to do too much, mixing Relay with unrelated implementation details. My goal with this article is to break down the the Relay workflow and point out some of the, probably temporary, rough edges in the library. Hopefully it will help somebody.

## Background

We assume that the reader already has a good understanding [React](http://facebook.github.io/react/) and a basic understanding of [GraphQL](https://github.com/facebook/graphql). If you are not already familiar with these, we highly suggest reading through the docs on their respective sites.

We will implement our GraphQL server using [GraphQL-Ruby](https://github.com/rmosolgo/graphql-ruby) and [GraphQL-Relay-Ruby](https://github.com/rmosolgo/graphql-relay-ruby) on top of a Rails app. We chose Rails for a couple reasons. First, a lot of business logic in the world is encapsulated in Rails models. We found it much easier to sell our bosses on adding a GraphQL endpoing onto an existing API as opposed to creating a whole new service. Second, Rails + ActiveRecord is an amazing combination for dealing with database complexity. I'm sure Node has some good ORM libraries, but I have yet to find anything that is as easy to work with as ActiveRecord.

Using GraphQL-Ruby/Rails backend has a useful side benefit, we can clearly deliniate the backend code from the front-end code. This was frequently a source of confusion for us as we worked our way through the documentation, tutorials, and examples. Also, it means our examples will be backed by real databases instead of faked data.

## Getting Started

So, let us assume we have a a Rails application built around Disney's Fairies books/movies. Specifically, it has a list of fairies and tracks their talents, location, and friends. Sadly, I did not think to implement the code base like this prior to adding some basic GraphQL/GraphiQL stuff, but a pretty good approximation is this [commit](https://github.com/HurricaneJames/relay-play/tree/041f1981a7fd7a101dd1d671c74ef444cf3677e3).

    Note: I came up with the idea for a Fairy database because my daughter was sitting on my lap watching one of the Tinker Bell movies on my second monitor while I was trying to learn Relay on the other one. At which point I had a brilliant idea, I should do examples/demos based on things my daughter likes in the hopes of encouraging her to code when she gets older. Now I fear that I am reinforcing some gender stereotype. There is probably a whole gender theory disertation that can be written here, but since I'm an engineer and more interested in getting stuff done, I'm relegating the whole discussion to this footnote. If anybody has comments on the matter, please feel free to leave them. I love my daughter and want to encourage her to do interesting things.

## Adding GraphQL to a Rails Application

This could probably be a whole article itself, but here are some highlights.

Add GraphQL to the `Gemfile`

    gem 'graphql'

Then `bundle install`.

Next, add a GraphqlController.

    class GraphqlController < ApplicationController
      layout false

      def exec
        query_string = params[:query]
        query_variables = params[:variables] || {}

        query = GraphQL::Query.new(RelayPlay::Schema, query_string, variables: query_variables)
        render json: query.result
      end

      def graphiql
      end
    end

Add a routes to `/config/routes.rb`

    match 'graphql', to: 'graphql#exec', via: [:get, :post]


Now we can process GraphQL queries on our server at `/graphql`. I also highly recommend setting up a GraphiQL endpoint. This is way beyond the scope of this article, but you can follow this [commit](https://github.com/HurricaneJames/relay-play/commit/c0244a398ec3791e0703c1b296b5ef46f7e1a5b9) on the codebase to get a pretty good idea.

I find it is helpful to put GraphQL models in `/app/graph/[domain]`. Rails automagically loads the fails in `/app/graph` if you name them correctly. In this case, I start with a namespace `RelayPlay` and add namespaces for `Types` and `Mutations`. As this is an article about Relay, we will not spend too much time on GraphQL-Ruby. For now, we will just look at the `Schema` and a basic query for the fairies.

    # /app/graph/relay_play/schema.rb
    module RelayPlay
      Schema = GraphQL::Schema.new(query: RelayPlay::QueryType, mutation: RelayPlay::MutationType)
    end

    # /app/graph/relay_play/query_type.rb
    module RelayPlay
      QueryType = GraphQL::ObjectType.define do
        name "Queries"
        description "The query root for this schema"

        field :fairies do
          type types[ RelayPlay::Types::FairyType ]
          description "Fairies"
          resolve -> (obj, args, ctx) do
            Fairy.all
          end
        end
      end
    end

    # /app/graph/relay_play/types/fairy_type.rb
    module RelayPlay
      module Types
        FairyType = GraphQL::ObjectType.define do
          name 'Fairy'

          field :name, !types.String

          field :talent, -> { !RelayPlay::Types::TalentType }
          field :region, -> { !RelayPlay::Types::RegionType }

          field :friends, -> { types[RelayPlay::Types::FairyType] }
        end
      end
    end

This schema gives us a way to queries for all the fairies (no pagination) and get their important properties via GraphQL. So, lets run a query on our sample data.

    query ourFairies {
      fairies { name }
    }

Running this through our GraphQL endpoing returns

    {
      "data": {
        "fairies": [
          {
            "name": "Fawn"
          },
          {
            "name": "Iridessa"
          },
          {
            "name": "Periwinkle"
          }
        ]
      }
    }

Yay!

## Adding Relay to our Server

Alright, so now we have a Rails app that has a GraphQL endpoint, and it was not even all that difficult. Adding Relay should be simple too, right? Actually, with the clarity of hindsight, it is not that bad.

***** ***** ***** ***** ***** *****
Need a line about Relay Conventions
***** ***** ***** ***** ***** *****



Next, add GraphQL-Relay, `gem 'graphql-relay'`, to our `Gemfile` and run `bundle install`.

Then we update `QueryType` to conform to Relay conventions.





## Setting up the GraphQL Client

## Conclusion