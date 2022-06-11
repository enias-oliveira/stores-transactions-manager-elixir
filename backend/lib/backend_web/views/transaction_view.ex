defmodule BackendWeb.TransactionView do
  use BackendWeb, :view
  alias BackendWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, TransactionView, "transaction.json")
  end

  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      date: transaction.date,
      value: transaction.value,
      cpf: transaction.cpf,
      card: transaction.card,
      storeId: transaction.store.id,
      transactionTypeId: transaction.transactionType.id
    }
  end
end
