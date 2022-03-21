# TestApp

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## RUN DOCKER
docker-compose up -d

## BRAND LIST
curl -XGET -H "Content-type: application/json" 'http://localhost:4000/brands'

## CREATE CAR
curl -XPOST -H "Content-type: application/json" -d '{
"brand_id": "$brand_id",
"model": "IX",
"year": 2022,
"body_type": "cuv",
"is_electric": true
}' 'http://localhost:4000/cars'

## CREATE CAR
curl -XPOST -H "Content-type: application/json" -d '{
"brand_id": "$brand_id",
"model": "Corolla",
"year": 2005,
"body_type": "sedan",
"is_electric": false
}' 'http://localhost:4000/cars'

## GET CAR LIST
curl -XGET -H "Content-type: application/json" 'http://localhost:4000/cars?brand=BMW&body_type=cuv&is_electric=true'

## CREATE CAR WITH INVALID PARAMS
curl -XPOST -H "Content-type: application/json" -d '{
"brand_id": "$brand_id",
"model": "Corolla",
"year": 1745,
"body_type": "sedan_sedan",
"is_electric": true
}' 'http://localhost:4000/cars'