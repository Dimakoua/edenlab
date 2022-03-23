defmodule TestAppWeb.CarView do
  use TestAppWeb, :view

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, TestAppWeb.CarView, "car_with_preload.json")}
  end

  def render("show.json", %{car: car}) do
    %{data: render_one(car, TestAppWeb.CarView, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      brand_id: car.brand_id,
      model: car.model,
      year: car.year,
      body_type: car.body_type,
      is_electric: car.is_electric
    }
  end

  def render("car_with_preload.json", %{car: car}) do
    %{
      brand: car.brand.name,
      model: car.model,
      year: car.year,
      body_type: car.body_type,
      is_electric: car.is_electric
    }
  end
end
