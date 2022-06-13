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

  describe "transactions" do
    alias Backend.Transactions.Transaction

    import Backend.TransactionsFixtures

    @invalid_attrs %{CPF: nil, card: nil, date: nil, value: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{CPF: "some CPF", card: "some card", date: "some date", value: 120.5}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.CPF == "some CPF"
      assert transaction.card == "some card"
      assert transaction.date == "some date"
      assert transaction.value == 120.5
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{CPF: "some updated CPF", card: "some updated card", date: "some updated date", value: 456.7}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.CPF == "some updated CPF"
      assert transaction.card == "some updated card"
      assert transaction.date == "some updated date"
      assert transaction.value == 456.7
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end

  describe "transactions" do
    alias Backend.Transactions.Transaction

    import Backend.TransactionsFixtures

    @invalid_attrs %{card: nil, cpf: nil, date: nil, value: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{card: "some card", cpf: "some cpf", date: "some date", value: 120.5}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.card == "some card"
      assert transaction.cpf == "some cpf"
      assert transaction.date == "some date"
      assert transaction.value == 120.5
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{card: "some updated card", cpf: "some updated cpf", date: "some updated date", value: 456.7}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.card == "some updated card"
      assert transaction.cpf == "some updated cpf"
      assert transaction.date == "some updated date"
      assert transaction.value == 456.7
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
