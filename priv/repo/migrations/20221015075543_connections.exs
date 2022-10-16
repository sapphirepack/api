defmodule MainApp.Repo.Migrations.Connections do
  use Ecto.Migration

  def change do
    create table(:connections) do
      add :provider, :string, null: false
      add :uconnection1, :string, null: false # Unique Connection detail slot 1
      add :uconnection2, :string, null: false # Unique Connection detail slot 2

      add :operator_id, references(:operators, column: "uuid", on_delete: :nothing, type: :binary_id)
      timestamps()
    end
  end
end
