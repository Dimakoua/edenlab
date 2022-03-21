defmodule TestApp.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :name, :string
    end

    create index(:brands, :name, unique: true)
  end
end
