defmodule MainApp.Accounts.Operator do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :uuid} # Since we don't have an id therefore we need to tell the path params what to use as the 'key'
  alias MainApp.Accounts.Operator
  alias MainApp.Repo
  alias Comeonin.Bcrypt

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "operators" do
    field :name, :string
    field :password_hash, :string
  end

  @doc false
  def changeset(%Operator{} = operator, attrs \\ %{}) do
    operator
    |> cast(attrs, [:name, :password_hash])
    |> unique_constraint([:name])
    |> validate_required([:name, :password_hash])
    |> update_change(:password_hash, &Bcrypt.hashpwsalt/1)
  end

  @spec createOrJoin(String.t(), String.t()) :: boolean
  def createOrJoin(name, password) do
    person = Repo.get_by(Operator, name: name)
    person # We need to consider two cases nil or not nil
    |> createifnotexist(name, password)
    |> checkpass(password) # need to look at the {:ok and :error}
  end

  defp createifnotexist(nil, name, password) do
    Operator.changeset(%Operator{}, %{ name: name, password_hash: password } )
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

    ### Custom Changeset Hacking START#
    ### Custom Changeset Hacking END#
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
