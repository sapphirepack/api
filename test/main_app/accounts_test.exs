defmodule MainApp.AccountsTest do
  use MainApp.DataCase

  alias MainApp.Accounts

  describe "operators" do
    alias MainApp.Accounts.Operator

    import MainApp.AccountsFixtures

    @invalid_attrs %{name: nil, password_hash: nil}

    test "list_operators/0 returns all operators" do
      operator = operator_fixture()
      assert Accounts.list_operators() == [operator]
    end

    test "get_operator!/1 returns the operator with given id" do
      operator = operator_fixture()
      assert Accounts.get_operator!(operator.id) == operator
    end

    test "create_operator/1 with valid data creates a operator" do
      valid_attrs = %{name: "some name", password_hash: "some password_hash"}

      assert {:ok, %Operator{} = operator} = Accounts.create_operator(valid_attrs)
      assert operator.name == "some name"
      assert operator.password_hash == "some password_hash"
    end

    test "create_operator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_operator(@invalid_attrs)
    end

    test "update_operator/2 with valid data updates the operator" do
      operator = operator_fixture()
      update_attrs = %{name: "some updated name", password_hash: "some updated password_hash"}

      assert {:ok, %Operator{} = operator} = Accounts.update_operator(operator, update_attrs)
      assert operator.name == "some updated name"
      assert operator.password_hash == "some updated password_hash"
    end

    test "update_operator/2 with invalid data returns error changeset" do
      operator = operator_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_operator(operator, @invalid_attrs)
      assert operator == Accounts.get_operator!(operator.id)
    end

    test "delete_operator/1 deletes the operator" do
      operator = operator_fixture()
      assert {:ok, %Operator{}} = Accounts.delete_operator(operator)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_operator!(operator.id) end
    end

    test "change_operator/1 returns a operator changeset" do
      operator = operator_fixture()
      assert %Ecto.Changeset{} = Accounts.change_operator(operator)
    end
  end
end
