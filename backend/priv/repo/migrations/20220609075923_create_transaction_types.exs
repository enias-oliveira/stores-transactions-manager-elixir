defmodule Backend.Repo.Migrations.CreateTransactionTypes do
  use Ecto.Migration

  def change do
    create table(:transaction_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string
      add :entryNature, :string

      timestamps()
    end
  end
end
