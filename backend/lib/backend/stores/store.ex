defmodule Backend.Stores.Store do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stores" do
    field :name, :string
    field :owner, :string
    field :totalBalance, :float

    has_many :transactions, Backend.Transactions.Transaction, foreign_key: :storeId

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :owner, :totalBalance])
    |> validate_required([:name, :owner, :totalBalance])
  end
end
