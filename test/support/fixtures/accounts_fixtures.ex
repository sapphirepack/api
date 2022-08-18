defmodule MainApp.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MainApp.Accounts` context.
  """

  @doc """
  Generate a operator.
  """
  def operator_fixture(attrs \\ %{}) do
    {:ok, operator} =
      attrs
      |> Enum.into(%{
        name: "some name",
        password_hash: "some password_hash"
      })
      |> MainApp.Accounts.create_operator()

    operator
  end
end
