defmodule Threehundred60Web.LocationController do
  use Threehundred60Web, :controller

  alias Threehundred60.Locations
  alias Threehundred60.Locations.Location
  alias Threehundred60.Categories

  def index(conn, _params) do
    locations = Locations.list_locations()
    render(conn, "index.html", locations: locations)
  end

  def new(conn, _params) do
    changeset = Locations.change_location(%Location{})
    categories = Categories.list_categories()
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"location" => location_params}) do
    case Locations.create_location(location_params) do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location created successfully.")
        |> redirect(to: Routes.location_path(conn, :show, location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, categories: Categories.list_categories())
    end
  end

  def show(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    render(conn, "show.html", location: location)
  end

  def edit(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    changeset = Locations.change_location(location)
    render(conn, "edit.html", location: location, changeset: changeset, categories: Categories.list_categories())
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Locations.get_location!(id)

    case Locations.update_location(location, location_params) do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location updated successfully.")
        |> redirect(to: Routes.location_path(conn, :show, location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", location: location, changeset: changeset, categories: Categories.list_categories())
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    {:ok, _location} = Locations.delete_location(location)

    conn
    |> put_flash(:info, "Location deleted successfully.")
    |> redirect(to: Routes.location_path(conn, :index))
  end
end
