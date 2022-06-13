defmodule BackendWeb.TransactionController do
  use BackendWeb, :controller

  alias Backend.Transactions
  alias Backend.Transactions.Transaction

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    transaction =
      %{transaction_params | "value" => trunc(transaction_params["value"] * 100)}
      |> Transactions.create_transaction()

    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
    |> render("show.json", transaction: transaction)
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Transactions.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end

  def create_from_upload(conn, %{"file" => file}) do
    transactions = Transactions.create_transactions_from_file(file)

    render(conn, "index.json", transactions: transactions)
  end
end
