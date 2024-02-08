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

  def new(%{"valor" => value, "tipo" => "d", "descricao" => description, "user_id" => user_id}) do
    %__MODULE__{
      value: value * -1,
      description: description,
      user_id: String.to_integer(user_id),
      created_at: NaiveDateTime.utc_now()
    }
  end

  def new(%{"valor" => value, "tipo" => "c", "descricao" => description, "user_id" => user_id}) do
    %__MODULE__{
      value: value,
      description: description,
      user_id: String.to_integer(user_id),
      created_at: NaiveDateTime.utc_now()
    }
  end

  def transaction_type(value) do
    if value < 0 do
      "d"
    else
      "c"
    end
  end
end
