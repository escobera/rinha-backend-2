defmodule Rinha2.Repo.Migrations.CreateClientsAndTransactions do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :limit, :int
      add :balance, :int
    end

    create constraint("users", :limit_check, check: "\"balance\" >= (\"limit\" * -1)")

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

    execute(
      """
      CREATE OR REPLACE FUNCTION update_balance()
      RETURNS TRIGGER
      LANGUAGE PLPGSQL
      AS
        $$
        BEGIN
          UPDATE users SET balance = balance + NEW.value WHERE id = NEW.user_id;

          RETURN NEW;
        END;
        $$
      """
    )

    execute("CREATE OR REPLACE TRIGGER transaction_create BEFORE INSERT ON transactions FOR EACH ROW EXECUTE PROCEDURE update_balance()")


  end
end
