defmodule TestApp.Cars.Car do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  @body_type [:sedan, :coupe, :pickup, :minivan, :cuv]
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "cars" do
    field :body_type, Ecto.Enum, values: @body_type
    field :is_electric, :boolean, default: false
    field :model, :string
    field :year, :integer

    field :brand_id, Ecto.UUID
    belongs_to :brand, TestApp.Brands.Brand, define_field: false
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:brand_id, :model, :year, :body_type, :is_electric])
    |> validate_required([:brand_id, :model, :year, :body_type, :is_electric])
    |> validate_inclusion(:body_type, @body_type)
    |> validate_inclusion(:year, 1886..Date.utc_today.year)
    |> assoc_constraint(:brand)
  end
end
