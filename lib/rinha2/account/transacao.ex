defmodule Rinha2.Account.Transaction do
  use Ecto.Schema

  alias Rinha2.Repo

  schema "transactions" do
    field :value, :integer
    field :type, :integer
    field :description, :string
  end

  def new(%{"value" => value, "type" => type, "description" => description}) do
    %__MODULE__{value: value, type: type, description: description}
  end

  def insert(transaction) do
    Repo.insert(transaction)
  end
end
