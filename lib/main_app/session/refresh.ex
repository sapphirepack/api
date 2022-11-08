defmodule MainApp.Session.Refresh do
  use Ecto.Schema
  import Ecto.Changeset

  alias MainApp.Accounts.Operator
  alias MainApp.Session.Access
  alias MainApp.Session.Refresh

  schema "refreshes" do
    field(:refreshtoken, :string) # The refresh token is 64 bytes
    belongs_to(:operator, Operator, type: :binary_id, references: :uuid)
    belongs_to(:accesses,  Access)
    timestamps()
  end

  def changeset(%Refresh{} = refresh, attrs \\ %{}) do
    refresh
    |> cast(attrs, [:refreshtoken])
    |> validate_required([:refreshtoken])
    |> unique_constraint(:refreshtoken)
  end
end
