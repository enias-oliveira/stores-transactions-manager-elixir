defmodule Backend.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Transactions` context.
  """

  @doc """
  Generate a transaction_types.
  """
  def transaction_types_fixture(attrs \\ %{}) do
    {:ok, transaction_types} =
      attrs
      |> Enum.into(%{
        description: :debit_payment,
        entryNature: :debit
      })
      |> Backend.Transactions.create_transaction_types()

    transaction_types
  end
end
