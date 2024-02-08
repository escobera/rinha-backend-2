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

  # def build_and_validate(params) do
  #   transaction = build(params)
  #   changeset = changeset(transaction, params)
  #   case changeset.valid? do
  #     true -> {:ok, changeset}
  #     false -> {:error, changeset}
  #   end
  # end

  def transaction_type(value) do
    if value < 0 do
      "d"
    else
      "c"
    end
  end

  # def changeset(transaction, attrs) do
  #   transaction
  #   |> cast(attrs, [:value, :description, :user_id])
  #   |> validate_number(:value, greater_than: 0)
  #   |> validate_integer(:value)
  # end

  # defp validate_integer(changeset, field) do
  #   case get_field(changeset, field) do
  #     nil -> changeset
  #     value when is_integer(value) -> changeset
  #     _ -> add_error(changeset, field, "deve ser um número inteiro")
  #   end
  # end
end
