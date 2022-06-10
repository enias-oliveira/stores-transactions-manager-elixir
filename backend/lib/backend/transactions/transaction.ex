defmodule Backend.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :card, :string
    field :cpf, :string
    field :date, :string
    field :value, :float
    field :transactionTypeId, :integer
    belongs_to :store, Backend.Stores.Store, foreign_key: :storeId

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:date, :value, :cpf, :card])
    |> validate_required([:date, :value, :cpf, :card])
  end
end
