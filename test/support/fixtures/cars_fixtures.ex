defmodule TestApp.CarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApp.Cars` context.
  """
  alias TestApp.Repo

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    brand = TestApp.BrandsFixtures.brand_fixture()
    {:ok, car} =
      attrs
      |> Enum.into(%{
        body_type: :sedan,
        is_electric: true,
        model: "some model",
        year: 2012,
        brand_id: brand.id,
      })
      |> TestApp.Cars.create_car()

    car
  end

  def car_fixture_with_brand(attrs \\ %{}) do
    brand = TestApp.BrandsFixtures.brand_fixture()

    {:ok, car} =
      attrs
      |> Enum.into(%{
        body_type: :sedan,
        is_electric: true,
        model: "some model",
        year: 2012,
        brand_id: brand.id,
      })
      |> TestApp.Cars.create_car()

      Repo.preload(car, :brand)
  end
end
