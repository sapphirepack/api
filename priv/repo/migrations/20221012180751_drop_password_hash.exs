defmodule MainApp.Repo.Migrations.DropPasswordHash do
  use Ecto.Migration

  def change do
    alter table("operators") do
      remove :password_hash, :string
    end
  end
end
