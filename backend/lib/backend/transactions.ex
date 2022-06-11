defmodule Backend.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Transactions.TransactionTypes

  alias Backend.Stores
  alias Backend.Transactions

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

  alias Backend.Transactions.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction) |> Repo.preload([:store, :transactionType])
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id) |> Repo.preload(:store)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    changeset =
      %Transaction{}
      |> Transaction.changeset(attrs)
      |> add_store(attrs)
      |> add_transaction_type(attrs)

    with {:ok, transaction} <- changeset |> Repo.insert() do
      transaction
      |> Repo.preload([:store, :transactionType])
    end
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp add_store(changeset, attrs) do
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
