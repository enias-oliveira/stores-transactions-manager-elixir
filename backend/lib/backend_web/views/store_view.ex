defmodule BackendWeb.StoreView do
  use BackendWeb, :view
  alias BackendWeb.StoreView

  def render("index.json", %{stores: stores}) do
    render_many(stores, StoreView, "store.json")
  end

  def render("show.json", %{store: store}) do
    render_one(store, StoreView, "store.json")
  end

  def render("store.json", %{store: store}) do
    %{
      id: store.id,
      name: store.name,
      owner: store.owner,
      totalBalance: store.totalBalance
    }
  end
end
