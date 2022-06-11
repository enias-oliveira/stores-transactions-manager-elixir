defmodule BackendWeb.StoreController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Stores
  alias Backend.Stores.Store
  alias Backend.Transactions.Transaction

  action_fallback(BackendWeb.FallbackController)

  def index(conn, _params) do
    stores = Stores.list_stores()

    render(conn, "index.json", stores: stores)
  end

  def create(conn, %{"store" => store_params}) do
    with {:ok, %Store{} = store} <- Stores.create_store(store_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.store_path(conn, :show, store))
      |> render("show.json", store: store)
    end
  end

  def show(conn, %{"id" => id}) do
    store = Stores.get_store!(id)
    render(conn, "show.json", store: store)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Stores.get_store!(id)

    with {:ok, %Store{} = store} <- Stores.update_store(store, store_params) do
      render(conn, "show.json", store: store)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Stores.get_store!(id)

    with {:ok, %Store{}} <- Stores.delete_store(store) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_transactions(conn, %{"storeId" => id}) do
    store = Stores.get_store!(id)

    render(conn, "store_transactions.json", store: store)
  end
end
