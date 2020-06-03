defmodule Threehundred60.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :information, :string
      add :longtitude, :float
      add :langtitude, :float
      add :video_url, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:category_id])
  end
end
