defmodule MainApp.Accounts.Operator do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :uuid} # Since we don't have an id therefore we need to tell the path params what to use as the 'key'
  alias MainApp.Accounts.Operator
  alias MainApp.Accounts.Connection
  alias MainApp.Repo

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "operators" do
    field :name, :string

    has_many :connections, Connection, foreign_key: :operator_id
  end

  @doc false
  def changeset(%Operator{} = operator, attrs \\ %{}) do
    operator
    |> cast(attrs, [:name])
  end

  def createOrJoin(name, password) do
    false
  end

  defp createifnotexist(nil, name) do
    Operator.changeset(%Operator{}, %{ name: name} )
    |> Repo.insert()
  end

  defp createifnotexist(operator , _name, _password) do
    {:ok, operator}
  end

  defp checkpass({:error, reason}, _ ) do
    Bcrypt.dummy_checkpw()
    {:reason, reason}
  end

  defp checkpass({:ok, operator}, password) do
    validpass = Bcrypt.checkpw(password, operator.password_hash)
    validpass
    |> returnvalue({:ok, operator}, {:error, "Incorrect password"})
  end

  defp returnvalue(true, success, _fail) do
    success
  end

  defp returnvalue(false, _success, fail) do
    fail
  end
end
