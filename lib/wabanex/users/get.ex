defmodule Wabanex.Users.Get do
  import Ecto.Query

  alias Wabanex.{User, Training, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_reponse()
  end

  defp handle_reponse(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_reponse({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    query =
      from t in Training,
        where: ^today >= t.start_date and ^today <= t.end_date
    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
