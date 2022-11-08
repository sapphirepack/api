# 1) Database schema
#   Access Token
#   ID [Access_Token (256 bits) base64 encoded] [OperatorID][Timestamps()]

#   Refresh Token
#   ID [Refresh_Token (512 bits) base64 encoded] [OperatorID] [Access_Token] [Timestamps()]

# Case 1)

# Login
#   -> Generate a Refresh and Access Token and return

# Logout
#   -> Revoke refresh and access token w/ given refresh token

# Refresh
#   -> Revoke previous refresh token and access token. Return new pair

defmodule MainApp.Session do

  alias MainApp.Repo
  alias MainApp.Accounts.Operator
  alias MainApp.Session.Access
  alias MainApp.Session.Refresh

  def login(%Operator{} = operator) do
    # Generate both random tokens
    accesstoken = :crypto.strong_rand_bytes(32) |> Base.encode64
    refreshtoken = :crypto.strong_rand_bytes(64) |> Base.encode64()

    access = Access.changeset(%Access{}, %{accesstoken: accesstoken})
    refresh = Refresh.changeset(%Refresh{}, %{refreshtoken: refreshtoken})

    {:ok, access_ecto} = Repo.insert(access)
    {:ok, refresh_ecto} = Repo.insert(refresh)

    access_ecto_loaded = Repo.get(Access, access_ecto.id) |> Repo.preload([:operator])

    access_ecto_loaded
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:operator, operator)
    |> Repo.update()

    refresh_ecto_loaded = Repo.get(Refresh, refresh_ecto.id) |> Repo.preload([:operator, :accesses])

    refresh_ecto_loaded
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:operator, operator)
    |> Ecto.Changeset.put_assoc(:accesses,access_ecto)
    |> Repo.update()
    # Need to link to operator for access_ecto and

    %{
        access_token: access_ecto.accesstoken,
        refresh_token: refresh_ecto.refreshtoken
      }
   end
end
