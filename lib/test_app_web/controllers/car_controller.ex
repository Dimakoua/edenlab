defmodule TestAppWeb.CarController do
  use TestAppWeb, :controller

  alias TestApp.Cars

  def index(conn, params) do
    cars = Cars.list_cars(params)

    render(conn, "index.json", cars: cars)
  end

  def create(conn, car_params) do
    case Cars.create_car(car_params) do
      {:ok, car} ->
        conn
        |> put_status(200)
        |> render("show.json", car: car)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TestAppWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end
