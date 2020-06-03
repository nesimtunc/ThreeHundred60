defmodule Threehundred60Web.LocationControllerTest do
  use Threehundred60Web.ConnCase

  alias Threehundred60.Locations
  alias Threehundred60.Categories

  @create_attrs %{information: "some information", latitude: 120.5, longtitude: 120.5, name: "some name", video_url: "some video_url"}
  @update_attrs %{information: "some updated information", latitude: 456.7, longtitude: 456.7, name: "some updated name", video_url: "some updated video_url"}
  @invalid_attrs %{information: nil, latitude: nil, longtitude: nil, name: nil, video_url: nil, category_id: nil}

  def fixture(:location) do
    category = create_category()
    attrs = Map.merge(@create_attrs, %{category_id: category.id})
    {:ok, location} = Locations.create_location(attrs)
    location
  end

  defp create_category() do
    {:ok, category} = Categories.create_category(%{ name: "Test Category"})
    category
  end

  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get(conn, Routes.location_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Locations"
    end
  end

  describe "new location" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.location_path(conn, :new))
      assert html_response(conn, 200) =~ "New Location"
    end
  end

  describe "create location" do

    test "redirects to show when data is valid", %{conn: conn} do

      category = create_category()

      attrs = Map.merge(@create_attrs, %{ category_id: category.id })

      conn = post(conn, Routes.location_path(conn, :create), location: attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.location_path(conn, :show, id)

      conn = get(conn, Routes.location_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Location"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.location_path(conn, :create), location: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Location"
    end
  end

  describe "edit location" do
    setup [:create_location]

    test "renders form for editing chosen location", %{conn: conn, location: location} do
      conn = get(conn, Routes.location_path(conn, :edit, location))
      assert html_response(conn, 200) =~ "Edit Location"
    end
  end

  describe "update location" do
    setup [:create_location]

    test "redirects when data is valid", %{conn: conn, location: location} do
      conn = put(conn, Routes.location_path(conn, :update, location), location: @update_attrs)
      assert redirected_to(conn) == Routes.location_path(conn, :show, location)

      conn = get(conn, Routes.location_path(conn, :show, location))
      assert html_response(conn, 200) =~ "some updated information"
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn = put(conn, Routes.location_path(conn, :update, location), location: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Location"
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete(conn, Routes.location_path(conn, :delete, location))
      assert redirected_to(conn) == Routes.location_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.location_path(conn, :show, location))
      end
    end
  end

  defp create_location(_) do
    location = fixture(:location)
    %{location: location}
  end
end
