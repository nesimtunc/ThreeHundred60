defmodule Threehundred60.LocationsTest do
  use Threehundred60.DataCase

  alias Threehundred60.Locations
  alias Threehundred60.Categories

  describe "locations" do
    alias Threehundred60.Locations.Location

    @valid_attrs %{information: "some information", latitude: 120.5, longtitude: 120.5, name: "some name", video_url: "some video_url"}
    @update_attrs %{information: "some updated information", latitude: 456.7, longtitude: 456.7, name: "some updated name", video_url: "some updated video_url"}
    @invalid_attrs %{information: nil, latitude: nil, longtitude: nil, name: nil, video_url: nil, category_id: nil}

    def location_fixture() do

      category = create_category()
      attrs = Map.merge(@valid_attrs, %{category_id: category.id})

      {:ok, location} =
        attrs
        |> Enum.into(attrs)
        |> Locations.create_location()

      location
    end

    defp create_category() do
      {:ok, category} = Categories.create_category(%{ name: "Test Category"})
      category
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do

      category = create_category()
      attrs = Map.merge(@valid_attrs, %{category_id: category.id})

      assert {:ok, %Location{} = location} = Locations.create_location(attrs)
      assert location.information == "some information"
      assert location.latitude == 120.5
      assert location.longtitude == 120.5
      assert location.name == "some name"
      assert location.video_url == "some video_url"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Locations.update_location(location, @update_attrs)
      assert location.information == "some updated information"
      assert location.latitude == 456.7
      assert location.longtitude == 456.7
      assert location.name == "some updated name"
      assert location.video_url == "some updated video_url"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
