defmodule TestAppWeb.ChangesetView do
  use TestAppWeb, :view
  alias TestApp.Cars.Car

  def translate_errors(%Ecto.Changeset{errors: errors}) do
    Enum.map(errors, fn {key, error} ->
      entry_type = type(Car.__schema__(:type, key))

      %{
        entry: key,
        entry_type: entry_type,
        rules: [rules(error)]
      }
    end)
  end

  defp type(entry_type) do
    case entry_type do
      Ecto.UUID -> "uuid"
      {_, Ecto.Enum, _} -> "enum"
      type -> type
    end
  end

  defp rules(error) do
    case error do
      {_, [type: {_, Ecto.Enum, %{mappings: mappings}}, validation: :cast]} ->
        %{
          description: translate_error(error),
          values: Keyword.values(mappings) |> Enum.join(","),
          validation: "subset"
        }

      {_, [type: Ecto.UUID, validation: _]} ->
        %{
          description: translate_error(error),
          validation: "exists"
        }

      {_, [validation: :inclusion, enum: from..to]} ->
        %{
          description: translate_error(error),
          values: %{from: from, to: to},
          validation: "inclusion"
        }

      {_, [validation: validation]} ->
        %{
          description: translate_error(error),
          validation: validation
        }

      _ ->
        %{
          description: translate_error(error)
        }
    end
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{error: %{invalid: translate_errors(changeset)}}
  end
end
