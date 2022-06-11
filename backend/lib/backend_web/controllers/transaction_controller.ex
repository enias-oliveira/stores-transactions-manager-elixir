defmodule BackendWeb.TransactionController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Transactions
  alias Backend.Transactions.Transaction
  alias Backend.Stores
  alias Backend.Stores.Store

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    transactions = Transactions.list_transactions() |> Repo.preload([:store, :transactionType])
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    transaction =
      Stores.get_store!(transaction_params["storeId"])
      |> Ecto.build_assoc(:transactions, %{
        date: transaction_params["date"],
        value: transaction_params["value"],
        cpf: transaction_params["cpf"],
        card: transaction_params["card"]
      })
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(
        :transactionType,
        Transactions.get_transaction_types!(transaction_params["transactionTypeId"])
      )
      |> Repo.insert!()
      |> Repo.preload([:store, :transactionType])

    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
    |> render("show.json", transaction: transaction)
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id) |> Repo.preload(:store)
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
end
