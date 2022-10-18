defmodule MainApp.AccountsTest do
  use MainApp.DataCase

  alias MainApp.Accounts

  describe "operators" do
    alias MainApp.Accounts.Operator

    import MainApp.AccountsFixtures

    @invalid_attrs %{name: nil, password_hash: nil}


  end
end
