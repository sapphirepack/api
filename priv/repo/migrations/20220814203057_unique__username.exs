defmodule MainApp.Repo.Migrations.Unique_Username do
  use Ecto.Migration

  def change do
    create unique_index(:operators, [:name])

  end
end
