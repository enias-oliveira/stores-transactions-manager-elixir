defmodule Backend.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Stores
  alias Backend.Stores.Store

  alias Backend.Transactions
  alias Backend.Transactions.TransactionTypes

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :card, :string
    field :cpf, :string
    field :date, :string
    field :value, :integer

    belongs_to :store, Store, foreign_key: :storeId
    belongs_to :transactionType, TransactionTypes, foreign_key: :transactionTypeId, type: :integer

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    attrs = parse_attrs(attrs)

    transaction
    |> cast(attrs, [:date, :value, :cpf, :card])
    |> add_transactions(attrs)
    |> add_transaction_type(attrs)
    |> validate_required([:date, :value, :cpf, :card])
  end

  defp parse_attrs(attrs) do
    %{attrs | "value" => trunc(attrs["value"] * 100)}
  end

  defp add_transactions(changeset, attrs) do
    changeset
    |> Ecto.Changeset.put_assoc(:store, Stores.get_store!(attrs["storeId"]))
  end

  defp add_transaction_type(changeset, attrs) do
    changeset
    |> Ecto.Changeset.put_assoc(
      :transactionType,
      Transactions.get_transaction_types!(attrs["transactionTypeId"])
    )
  end
end
