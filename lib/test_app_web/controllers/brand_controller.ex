defmodule TestAppWeb.BrandController do
  use TestAppWeb, :controller

  alias TestApp.Brands

  def index(conn, _params) do
    brands = Brands.list_brands()
    render(conn, "index.json", brands: brands)
  end
end
