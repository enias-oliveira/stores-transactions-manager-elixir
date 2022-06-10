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

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        CPF: "some CPF",
        card: "some card",
        date: "some date",
        value: 120.5
      })
      |> Backend.Transactions.create_transaction()

    transaction
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        card: "some card",
        cpf: "some cpf",
        date: "some date",
        value: 120.5
      })
      |> Backend.Transactions.create_transaction()

    transaction
  end
end
