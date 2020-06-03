defmodule Threehundred60.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  @all_fields ~w(name information longtitude latitude video_url category_id)a

  schema "locations" do
    field :information, :string
    field :latitude, :float
    field :longtitude, :float
    field :name, :string
    field :video_url, :string
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, @all_fields)
    |> validate_required(@all_fields)
  end
end
