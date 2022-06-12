defmodule Backend.Transactions.FileProcessor do
  alias Backend.Repo
  alias Backend.Stores.Store

  def normalize(file) do
    file
    |> parse_file()
    |> Enum.map(&normalize_raw_line/1)
  end

  defp normalize_raw_line(raw_line) do
    transaction_type_id = String.at(raw_line, 0) |> String.to_integer()

    date = (String.slice(raw_line, 1..8) <> String.slice(raw_line, 42..47)) |> convert_to_iso()

    value = String.slice(raw_line, 9..18) |> String.to_integer()
    cpf = String.slice(raw_line, 19..29)
    card = String.slice(raw_line, 30..41)
    store_owner = String.slice(raw_line, 48..61) |> String.trim()
    store_name = String.slice(raw_line, 62..80) |> String.trim()

    store = get_or_create_store(%Store{name: store_name, owner: store_owner})

    %{inserted_at: inserted_at, updated_at: updated_at} = timestamps()

    %{
      date: date,
      value: value,
      cpf: cpf,
      card: card,
      storeId: store.id,
      transactionTypeId: transaction_type_id,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  defp parse_file(file) do
    File.read!(file.path) |> String.split("\n", trim: true)
  end

  defp convert_to_iso(raw_date),
    do: raw_date |> Timex.parse!("%Y%m%d%H%M%S", :strftime) |> Timex.format!("{ISO:Extended:Z}")

  defp get_or_create_store(store) do
    Repo.insert!(store,
      on_conflict: :nothing,
      returning: true
    )

    Repo.get_by!(Store, name: store.name)
  end

  defp timestamps() do
    %{
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    }
  end
end
