defmodule Threehundred60.Repo.Migrations.RenameLangtitudeToLatitude do
  use Ecto.Migration

  def change do
    rename table(:locations), :langtitude, to: :latitude
  end
end
