defmodule Backend.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :string
      add :value, :float
      add :cpf, :string
      add :card, :string
      add :transactionTypeId, references(:transaction_types, on_delete: :nothing, type: :integer)
      add :storeId, references(:stores, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:transactions, [:transactionTypeId])
    create index(:transactions, [:storeId])
  end
end
