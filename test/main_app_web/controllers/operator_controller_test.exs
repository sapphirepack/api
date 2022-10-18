defmodule MainAppWeb.OperatorControllerTest do
  use MainAppWeb.ConnCase

  import MainApp.AccountsFixtures

  

  defp create_operator(_) do
    operator = operator_fixture()
    %{operator: operator}
  end
end
