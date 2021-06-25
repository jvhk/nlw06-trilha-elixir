defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, _content), do: Wabanex.Trainings.Create.call(params)
end
