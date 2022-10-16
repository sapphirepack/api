defmodule MainApp.Repo.Migrations.OperatorDatabase do
  use Ecto.Migration

  def change do
    create table(:operators, primary_key: false ) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :password_hash, :string # Data is encoded in base64 so we're not dealing with direct binary.

    end
  end
end
