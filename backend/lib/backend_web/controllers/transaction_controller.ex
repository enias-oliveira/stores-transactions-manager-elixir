defmodule BackendWeb.TransactionController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Transactions
  alias Backend.Transactions.Transaction
  alias Backend.Stores
  alias Backend.Stores.Store

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
    rawTransactions = File.read!(file.path) |> String.split("\n", trim: true)

    transactions_changesets =
      Enum.map(rawTransactions, fn
        rt ->
          type = String.at(rt, 0) |> String.to_integer()

          datetime =
            (String.slice(rt, 1..8) <> String.slice(rt, 42..47))
            |> Timex.parse!("%Y%m%d%H%M%S", :strftime)
            |> Timex.format!("{ISO:Extended:Z}")

          value = String.slice(rt, 9..18) |> String.to_integer()
          cpf = String.slice(rt, 19..29)
          card = String.slice(rt, 30..41)
          store_owner = String.slice(rt, 48..61) |> String.trim()
          store_name = String.slice(rt, 62..80) |> String.trim()

          Repo.insert!(%Store{name: store_name, owner: store_owner},
            on_conflict: :nothing,
            returning: true
          )

          store = Repo.get_by!(Store, name: store_name)

          %{
            date: datetime,
            value: value,
            cpf: cpf,
            card: card,
            storeId: store.id,
            transactionTypeId: type,
            inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
            updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
          }
      end)

    {count, transactions} = Repo.insert_all(Transaction, transactions_changesets, returning: true)

    render(conn, "index.json",
      transactions: transactions |> Repo.preload([:store, :transactionType])
    )
  end
end
