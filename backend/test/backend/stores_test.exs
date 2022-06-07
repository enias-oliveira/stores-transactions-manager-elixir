defmodule Backend.StoresTest do
  use Backend.DataCase

  alias Backend.Stores

  describe "stores" do
    alias Backend.Stores.Store

    import Backend.StoresFixtures

    @invalid_attrs %{name: nil, owner: nil, totalBalance: nil}

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Stores.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Stores.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      valid_attrs = %{name: "some name", owner: "some owner", totalBalance: 120.5}

      assert {:ok, %Store{} = store} = Stores.create_store(valid_attrs)
      assert store.name == "some name"
      assert store.owner == "some owner"
      assert store.totalBalance == 120.5
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stores.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      update_attrs = %{name: "some updated name", owner: "some updated owner", totalBalance: 456.7}

      assert {:ok, %Store{} = store} = Stores.update_store(store, update_attrs)
      assert store.name == "some updated name"
      assert store.owner == "some updated owner"
      assert store.totalBalance == 456.7
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Stores.update_store(store, @invalid_attrs)
      assert store == Stores.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Stores.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Stores.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Stores.change_store(store)
    end
  end
end
