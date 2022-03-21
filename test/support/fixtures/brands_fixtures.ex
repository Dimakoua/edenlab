defmodule TestApp.BrandsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApp.Brands` context.
  """

  @doc """
  Generate a brand.
  """
  def brand_fixture(attrs \\ %{}) do
    {:ok, brand} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TestApp.Brands.create_brand()

    brand
  end
end
