defmodule BackendWeb.StoreControllerTest do
  use BackendWeb.ConnCase

  import Backend.StoresFixtures

  alias Backend.Stores.Store

  @create_attrs %{
    name: "some name",
    owner: "some owner",
    totalBalance: 120.5
  }
  @update_attrs %{
    name: "some updated name",
    owner: "some updated owner",
    totalBalance: 456.7
  }
  @invalid_attrs %{name: nil, owner: nil, totalBalance: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stores", %{conn: conn} do
      conn = get(conn, Routes.store_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create store" do
    test "renders store when data is valid", %{conn: conn} do
      conn = post(conn, Routes.store_path(conn, :create), store: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.store_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "owner" => "some owner",
               "totalBalance" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.store_path(conn, :create), store: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update store" do
    setup [:create_store]

    test "renders store when data is valid", %{conn: conn, store: %Store{id: id} = store} do
      conn = put(conn, Routes.store_path(conn, :update, store), store: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.store_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "owner" => "some updated owner",
               "totalBalance" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, store: store} do
      conn = put(conn, Routes.store_path(conn, :update, store), store: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete store" do
    setup [:create_store]

    test "deletes chosen store", %{conn: conn, store: store} do
      conn = delete(conn, Routes.store_path(conn, :delete, store))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.store_path(conn, :show, store))
      end
    end
  end

  defp create_store(_) do
    store = store_fixture()
    %{store: store}
  end
end
