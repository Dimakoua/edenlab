defmodule TestApp.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :model, :string
      add :year, :integer
      add :body_type, :string
      add :is_electric, :boolean, default: false, null: false
      add :brand_id, references(:brands, type: :uuid, on_delete: :delete_all)
    end

    create index(:cars, [:brand_id])
  end
end
