defmodule TestApp.Repo.Migrations.AddCarIndexes do
  use Ecto.Migration

  def change do
    create index(:cars, [:model, :year])
    create index(:cars, [:body_type])
  end
end
