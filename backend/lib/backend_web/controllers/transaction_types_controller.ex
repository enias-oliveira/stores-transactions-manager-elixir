defmodule BackendWeb.TransactionTypesController do
  use BackendWeb, :controller

  alias Backend.Transactions
  alias Backend.Transactions.TransactionTypes

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    transaction_types = Transactions.list_transaction_types()
    render(conn, "index.json", transaction_types: transaction_types)
  end

  def create(conn, %{"transaction_types" => transaction_types_params}) do
    with {:ok, %TransactionTypes{} = transaction_types} <- Transactions.create_transaction_types(transaction_types_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_types_path(conn, :show, transaction_types))
      |> render("show.json", transaction_types: transaction_types)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction_types = Transactions.get_transaction_types!(id)
    render(conn, "show.json", transaction_types: transaction_types)
  end

  def update(conn, %{"id" => id, "transaction_types" => transaction_types_params}) do
    transaction_types = Transactions.get_transaction_types!(id)

    with {:ok, %TransactionTypes{} = transaction_types} <- Transactions.update_transaction_types(transaction_types, transaction_types_params) do
      render(conn, "show.json", transaction_types: transaction_types)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction_types = Transactions.get_transaction_types!(id)

    with {:ok, %TransactionTypes{}} <- Transactions.delete_transaction_types(transaction_types) do
      send_resp(conn, :no_content, "")
    end
  end
end
