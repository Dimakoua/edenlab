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
    {:ok, car} =
      attrs
      |> Enum.into(%{
        body_type: :sedan,
        is_electric: true,
        model: "some model",
        year: 2012,
        brand_id: get_brand_id(attrs)
      })
      |> TestApp.Cars.create_car()

    car
  end

  defp get_brand_id(attrs) do
    if attrs[:brand_id] do
      attrs.brand_id
    else
      brand = TestApp.BrandsFixtures.brand_fixture()
      brand.id
    end
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
        brand_id: brand.id
      })
      |> TestApp.Cars.create_car()

    Repo.preload(car, :brand)
  end

  def cars_set do
    brand = TestApp.BrandsFixtures.brand_fixture(%{name: "BMW"})

    car_fixture(%{
      body_type: :sedan,
      is_electric: true,
      model: "i7",
      year: 2022,
      brand_id: brand.id
    })

    car_fixture(%{
      body_type: :cuv,
      is_electric: true,
      model: "iX",
      year: 2022,
      brand_id: brand.id
    })

    brand = TestApp.BrandsFixtures.brand_fixture(%{name: "Toyota"})

    car_fixture(%{
      body_type: :sedan,
      is_electric: false,
      model: "Corrola",
      year: 2005,
      brand_id: brand.id
    })

    car_fixture(%{
      body_type: :sedan,
      is_electric: true,
      model: "bZ4X",
      year: 2022,
      brand_id: brand.id
    })

    :ok
  end
end
