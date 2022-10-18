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

  def create_operator() do
    operator = Operator.changeset(%Operator{})

    {:ok, operatorReturned} = Repo.insert(operator)

    operatorReturned
  end
end
