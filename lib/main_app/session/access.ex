defmodule MainApp.Session.Access do
  use Ecto.Schema
  import Ecto.Changeset

  alias MainApp.Accounts.Operator
  alias MainApp.Session.Access

  schema "accesses" do
    field(:accesstoken, :string) # The Access Token is 32 bytes
    belongs_to(:operator, Operator, type: :binary_id, references: :uuid)

    timestamps()
  end

  def changeset(%Access{} = access, attrs \\ %{}) do
    access
    |> cast(attrs, [:accesstoken])
    |> validate_required([:accesstoken])
    |> unique_constraint(:accesstoken)
  end
end
