defmodule Backend.Transactions.TransactionTypes do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transaction_types" do
    field :description, Ecto.Enum, values: [:debit_payment, :boleto_payment, :financing, :credit_payment, :loan_payment, :sales, :ted_payment, :doc_payment, :rent]
    field :entryNature, Ecto.Enum, values: [:debit, :credit]

    timestamps()
  end

  @doc false
  def changeset(transaction_types, attrs) do
    transaction_types
    |> cast(attrs, [:description, :entryNature])
    |> validate_required([:description, :entryNature])
  end
end
