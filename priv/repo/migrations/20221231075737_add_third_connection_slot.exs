defmodule MainApp.Repo.Migrations.AddThirdConnectionSlot do
  use Ecto.Migration

  def change do
    alter table(:connections) do
      add :uconnection3, :string, null: false # Unique Connection detail slot 3

    end
  end
end
