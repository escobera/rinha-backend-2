defmodule Rinha2.Account.Transaction do
  use Ecto.Schema

  alias Rinha2.Account.User

  schema "transactions" do
    field :value, :integer
    field :type, :string, virtual: true
    field :description, :string
    field :created_at, :naive_datetime_usec
    belongs_to :user, User
  end

  def build(%{"valor" => value}) when value < 0 or not is_integer(value),
    do: {:error, "Valor deve ser um inteiro positivo"}

  def build(%{"descricao" => desc}) when is_nil(desc) or byte_size(desc) < 1 or byte_size(desc) > 10,
    do: {:error, "Descrição deve ter entre 1 e 10 caracteres"}

  def build(%{"valor" => value, "tipo" => "d", "descricao" => description, "user_id" => user_id}) do
    {:ok,
     %__MODULE__{
       value: value * -1,
       description: description,
       user_id: String.to_integer(user_id),
       created_at: NaiveDateTime.utc_now()
     }}
  end

  def build(%{"valor" => value, "tipo" => "c", "descricao" => description, "user_id" => user_id}) do
    {:ok,
     %__MODULE__{
       value: value,
       description: description,
       user_id: String.to_integer(user_id),
       created_at: NaiveDateTime.utc_now()
     }}
  end

  def build(_params), do: {:error, "Parâmetros inválidos"}

  def transaction_type(value) do
    if value < 0 do
      "d"
    else
      "c"
    end
  end
end
