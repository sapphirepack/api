defmodule MainApp.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:accesses) do
      add :accesstoken, :string, null: false
      add :operator_id, references(:operators, column: "uuid", on_delete: :nothing, type: :binary_id)
      timestamps()
    end

    flush()

    create table(:refreshes) do
      add :refreshtoken, :string, null: false
      #   ID [Refresh_Token (512 bits) base64 encoded] [OperatorID] [Access_Token] [Timestamps()]
      add :operator_id, references(:operators, column: "uuid", on_delete: :nothing, type: :binary_id)
      add :accesses_id, references(:accesses, on_delete: :delete_all)
      timestamps()
    end
  end
end
