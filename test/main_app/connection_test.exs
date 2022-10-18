defmodule MainApp.ConnectionTest do
  use MainApp.DataCase

  describe "operators" do

    alias MainApp.Accounts
    alias MainApp.Accounts.Connection
    alias MainApp.Accounts.Operator

    test "connection seperate from operator" do
      operator = Accounts.signup_operator("email@end.com", "password")
      if (!operator) do
        throw "Operator Creation Failed"
      end
      Connection.delete_connection("email@end.com")
      assert Repo.get(Operator, operator.uuid) == operator
    end

  end
end
