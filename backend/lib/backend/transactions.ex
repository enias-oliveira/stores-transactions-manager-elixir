defmodule Backend.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Transactions.TransactionTypes

  @doc """
  Returns the list of transaction_types.

  ## Examples

      iex> list_transaction_types()
      [%TransactionTypes{}, ...]

  """
  def list_transaction_types do
    Repo.all(TransactionTypes)
  end

  @doc """
  Gets a single transaction_types.

  Raises `Ecto.NoResultsError` if the Transaction types does not exist.

  ## Examples

      iex> get_transaction_types!(123)
      %TransactionTypes{}

      iex> get_transaction_types!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction_types!(id), do: Repo.get!(TransactionTypes, id)

  @doc """
  Creates a transaction_types.

  ## Examples

      iex> create_transaction_types(%{field: value})
      {:ok, %TransactionTypes{}}

      iex> create_transaction_types(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction_types(attrs \\ %{}) do
    %TransactionTypes{}
    |> TransactionTypes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction_types.

  ## Examples

      iex> update_transaction_types(transaction_types, %{field: new_value})
      {:ok, %TransactionTypes{}}

      iex> update_transaction_types(transaction_types, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction_types(%TransactionTypes{} = transaction_types, attrs) do
    transaction_types
    |> TransactionTypes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction_types.

  ## Examples

      iex> delete_transaction_types(transaction_types)
      {:ok, %TransactionTypes{}}

      iex> delete_transaction_types(transaction_types)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction_types(%TransactionTypes{} = transaction_types) do
    Repo.delete(transaction_types)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction_types changes.

  ## Examples

      iex> change_transaction_types(transaction_types)
      %Ecto.Changeset{data: %TransactionTypes{}}

  """
  def change_transaction_types(%TransactionTypes{} = transaction_types, attrs \\ %{}) do
    TransactionTypes.changeset(transaction_types, attrs)
  end
end
