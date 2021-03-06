defmodule Backend.Repo.Migrations.CreateTransactionTypes do
  use Ecto.Migration

  def change do
    create table(:transaction_types) do
      add :description, :string
      add :entryNature, :string

      timestamps()
    end
  end
end
