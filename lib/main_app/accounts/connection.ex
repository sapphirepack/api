defmodule MainApp.Accounts.Connection do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias MainApp.Accounts.Operator
  alias MainApp.Accounts.Connection
  alias MainApp.Repo

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

  def create_connection(email, password) do
    connection = Connection.changeset(%Connection{},  %{ provider: "email", uconnection1: email, uconnection2: password})

    {:ok, connectionReturned} = Repo.insert(connection)

    connectionReturned
  end

  def delete_connection(email) do
    id = Repo.one(from c in Connection, where: c.provider == "email" and c.uconnection1 == ^email, select: c.id)
    if (!id) do
      false
    else
      deletedConnection = Repo.get(Connection, id)
      Repo.delete deletedConnection
      true
    end
  end
end
