defmodule Backend.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :owner, :string
      add :totalBalance, :float

      timestamps()
    end
  end
end
