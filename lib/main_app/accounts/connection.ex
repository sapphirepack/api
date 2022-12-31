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
    field(:uconnection3, :string)

    belongs_to(:operator, Operator, type: :binary_id, references: :uuid)

    timestamps()
  end

  def changeset(%Connection{} = connection, attrs \\ %{}) do
    connection
    |> cast(attrs, [:provider, :uconnection1, :uconnection2, :uconnection3])
    |> validate_required([:provider, :uconnection1, :uconnection2, :uconnection3])
  end

  def create_connection(email, password, salt) do
    connection = Connection.changeset(%Connection{},  %{ provider: "email", uconnection1: email, uconnection2: password, uconnection3: salt})

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
