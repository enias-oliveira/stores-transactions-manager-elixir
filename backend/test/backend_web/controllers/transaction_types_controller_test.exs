defmodule BackendWeb.TransactionTypesControllerTest do
  use BackendWeb.ConnCase

  import Backend.TransactionsFixtures

  alias Backend.Transactions.TransactionTypes

  @create_attrs %{
    description: :debit_payment,
    entryNature: :debit
  }
  @update_attrs %{
    description: :boleto_payment,
    entryNature: :credit
  }
  @invalid_attrs %{description: nil, entryNature: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transaction_types", %{conn: conn} do
      conn = get(conn, Routes.transaction_types_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction_types" do
    test "renders transaction_types when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_types_path(conn, :create), transaction_types: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transaction_types_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "debit_payment",
               "entryNature" => "debit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_types_path(conn, :create), transaction_types: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction_types" do
    setup [:create_transaction_types]

    test "renders transaction_types when data is valid", %{conn: conn, transaction_types: %TransactionTypes{id: id} = transaction_types} do
      conn = put(conn, Routes.transaction_types_path(conn, :update, transaction_types), transaction_types: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.transaction_types_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "boleto_payment",
               "entryNature" => "credit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction_types: transaction_types} do
      conn = put(conn, Routes.transaction_types_path(conn, :update, transaction_types), transaction_types: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction_types" do
    setup [:create_transaction_types]

    test "deletes chosen transaction_types", %{conn: conn, transaction_types: transaction_types} do
      conn = delete(conn, Routes.transaction_types_path(conn, :delete, transaction_types))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_types_path(conn, :show, transaction_types))
      end
    end
  end

  defp create_transaction_types(_) do
    transaction_types = transaction_types_fixture()
    %{transaction_types: transaction_types}
  end
end
