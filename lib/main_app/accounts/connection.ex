defmodule MainApp.Accounts.Connection do
  use Ecto.Schema
  import Ecto.Changeset

  alias MainApp.Accounts.Operator
  alias MainApp.Accounts.Connection

  schema "connections" do
    field(:provider, :string)
    field(:uconnection1, :string)
    field(:uconnection2, :string)

    belongs_to(:operator, Operator, type: :binary_id, references: :uuid)

    timestamps()
  end

  def changeset(%Connection{} = connection, attrs \\ %{}) do
    connection
    |> cast(attrs, [:provider, :uconnection1, :uconnection2])
    |> validate_required([:provider, :uconnection1, :uconnection2])
  end
end
