defmodule Backend.TransactionsTest do
  use Backend.DataCase

  alias Backend.Transactions

  describe "transaction_types" do
    alias Backend.Transactions.TransactionTypes

    import Backend.TransactionsFixtures

    @invalid_attrs %{description: nil, entryNature: nil}

    test "list_transaction_types/0 returns all transaction_types" do
      transaction_types = transaction_types_fixture()
      assert Transactions.list_transaction_types() == [transaction_types]
    end

    test "get_transaction_types!/1 returns the transaction_types with given id" do
      transaction_types = transaction_types_fixture()
      assert Transactions.get_transaction_types!(transaction_types.id) == transaction_types
    end

    test "create_transaction_types/1 with valid data creates a transaction_types" do
      valid_attrs = %{description: :debit_payment, entryNature: :debit}

      assert {:ok, %TransactionTypes{} = transaction_types} = Transactions.create_transaction_types(valid_attrs)
      assert transaction_types.description == :debit_payment
      assert transaction_types.entryNature == :debit
    end

    test "create_transaction_types/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction_types(@invalid_attrs)
    end

    test "update_transaction_types/2 with valid data updates the transaction_types" do
      transaction_types = transaction_types_fixture()
      update_attrs = %{description: :boleto_payment, entryNature: :credit}

      assert {:ok, %TransactionTypes{} = transaction_types} = Transactions.update_transaction_types(transaction_types, update_attrs)
      assert transaction_types.description == :boleto_payment
      assert transaction_types.entryNature == :credit
    end

    test "update_transaction_types/2 with invalid data returns error changeset" do
      transaction_types = transaction_types_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction_types(transaction_types, @invalid_attrs)
      assert transaction_types == Transactions.get_transaction_types!(transaction_types.id)
    end

    test "delete_transaction_types/1 deletes the transaction_types" do
      transaction_types = transaction_types_fixture()
      assert {:ok, %TransactionTypes{}} = Transactions.delete_transaction_types(transaction_types)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction_types!(transaction_types.id) end
    end

    test "change_transaction_types/1 returns a transaction_types changeset" do
      transaction_types = transaction_types_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction_types(transaction_types)
    end
  end
end
