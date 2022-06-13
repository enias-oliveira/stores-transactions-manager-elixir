defmodule BackendWeb.TransactionTypesView do
  use BackendWeb, :view
  alias BackendWeb.TransactionTypesView

  def render("index.json", %{transaction_types: transaction_types}) do
    render_many(transaction_types, TransactionTypesView, "transaction_types.json")
  end

  def render("show.json", %{transaction_types: transaction_types}) do
    %{data: render_one(transaction_types, TransactionTypesView, "transaction_types.json")}
  end

  def render("transaction_types.json", %{transaction_types: transaction_types}) do
    %{
      id: transaction_types.id,
      description: String.upcase(Atom.to_string(transaction_types.description)),
      entryNature: String.upcase(Atom.to_string(transaction_types.entryNature))
    }
  end
end
