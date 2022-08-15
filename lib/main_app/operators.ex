defmodule MainApp.Operators do
  use Ecto.Schema
  import Ecto.Changeset

  alias MainApp.Operators
  alias MainApp.Repo
  alias Comeonin.Bcrypt

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "operators" do
    field :name, :string
    field :password_hash, :string
  end

  @doc false
  def changeset(%Operators{} = operator, attrs \\ %{}) do
    operator
    |> cast(attrs, [:name, :password_hash])
    |> unique_constraint([:name])
    |> validate_required([:name, :password_hash])
    |> update_change(:password_hash, &Bcrypt.hashpwsalt/1)
  end

  def createOrJoin(name, password) do
    person = Repo.get_by(Operators, name: name)

    person # We need to consider two cases nil or not nil
    |> createifnotexist(name, password) # We need to consider :error or :ok which needs to be reduced to just returning the %Operators{}
    |> checkpass(password) # need to look at the {:ok and :error}
  end

  defp createifnotexist(nil, name, password) do
    Operators.changeset(%Operators{}, %{ name: name, password_hash: password } )
    |> Repo.insert()
    |> normalizeoutput()
  end

  defp createifnotexist(operator , _name, _password) do
    # There's nothing that we need to do here so we'll take the operator
    operator
  end

  defp normalizeoutput({:error, _reasons}) do
    nil # Right now we're hiding what the error is
  end

  defp normalizeoutput({:ok, operator}) do
    operator
  end

  defp checkpass(nil, _ ) do
    Bcrypt.dummy_checkpw()
  end

  defp checkpass(operator, password) do
    Bcrypt.checkpw(password, operator.password_hash);
  end
end
