defmodule TestApp.Cars do
  @moduledoc """
  The Cars context.
  """

  import Ecto.Query, warn: false
  alias TestApp.Repo

  alias TestApp.Cars.Car
  alias TestApp.Brands.Brand

  @doc """
  Returns the list of cars.

  ## Examples

      iex> list_cars()
      [%Car{}, ...]

  """
  def list_cars([]) do
    Repo.all(Car)
    |> Repo.preload(:brand)
  end

  def list_cars(filters) do
    build_query(filters)
    |> Repo.all()
  end

  defp build_query(filters) do
    query = from(car in Car)

    query
    |> filter(filters)
    |> maybe_preload_brand(filters[:brand])
  end

  defp maybe_preload_brand(query, nil), do: query
  defp maybe_preload_brand(query, value) do
    from(cars in query,
      join: brand in Brand,
      on: brand.id == cars.brand_id,
      where: brand.name == ^value,
      preload: [brand: brand]
    )
  end

  defp filter(query, filters) do
    where = Keyword.take(filters, [:body_type, :is_electric, :model, :year])

    query
    |> where(^where)
  end
  @doc """
  Gets a single car.

  Raises `Ecto.NoResultsError` if the Car does not exist.

  ## Examples

      iex> get_car!(123)
      %Car{}

      iex> get_car!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car!(id), do: Repo.get!(Car, id)

  @doc """
  Creates a car.

  ## Examples

      iex> create_car(%{field: value})
      {:ok, %Car{}}

      iex> create_car(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car(attrs \\ %{}) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a car.

  ## Examples

      iex> update_car(car, %{field: new_value})
      {:ok, %Car{}}

      iex> update_car(car, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car(%Car{} = car, attrs) do
    car
    |> Car.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a car.

  ## Examples

      iex> delete_car(car)
      {:ok, %Car{}}

      iex> delete_car(car)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car(%Car{} = car) do
    Repo.delete(car)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car changes.

  ## Examples

      iex> change_car(car)
      %Ecto.Changeset{data: %Car{}}

  """
  def change_car(%Car{} = car, attrs \\ %{}) do
    Car.changeset(car, attrs)
  end
end
