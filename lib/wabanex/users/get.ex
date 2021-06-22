defmodule Wabanex.Users.Get do
  alias Wabanex.{User, Repo}
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
      user -> {:ok, user}
    end
  end
end
