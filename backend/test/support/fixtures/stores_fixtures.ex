defmodule Backend.StoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Stores` context.
  """

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        name: "some name",
        owner: "some owner",
        totalBalance: 120.5
      })
      |> Backend.Stores.create_store()

    store
  end
end
