defmodule Rinha2.Repo.Migrations.CreateClientsAndTransactions do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :limit, :int
      add :balance, :int
    end

    create table(:transactions) do
      add :user_id, references(:users)
      add :value, :int
      add :description, :string
      add :created_at, :naive_datetime_usec
    end

    execute("INSERT into users (id, \"limit\", balance) VALUES (1, 100000, 0)")
    execute("INSERT into users (id, \"limit\", balance) VALUES (2, 80000, 0)")
    execute("INSERT into users (id, \"limit\", balance) VALUES (3, 1000000, 0)")
    execute("INSERT into users (id, \"limit\", balance) VALUES (4, 10000000, 0)")
    execute("INSERT into users (id, \"limit\", balance) VALUES (5, 500000, 0)")

  end
end
