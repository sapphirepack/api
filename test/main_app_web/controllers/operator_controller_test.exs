defmodule MainAppWeb.OperatorControllerTest do
  use MainAppWeb.ConnCase

  import MainApp.AccountsFixtures

  @create_attrs %{name: "some name", password_hash: "some password_hash"}
  @update_attrs %{name: "some updated name", password_hash: "some updated password_hash"}
  @invalid_attrs %{name: nil, password_hash: nil}

  describe "index" do
    test "lists all operators", %{conn: conn} do
      conn = get(conn, Routes.operator_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Operators"
    end
  end

  describe "new operator" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.operator_path(conn, :new))
      assert html_response(conn, 200) =~ "New Operator"
    end
  end

  describe "create operator" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.operator_path(conn, :create), operator: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.operator_path(conn, :show, id)

      conn = get(conn, Routes.operator_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Operator"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.operator_path(conn, :create), operator: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Operator"
    end
  end

  describe "edit operator" do
    setup [:create_operator]

    test "renders form for editing chosen operator", %{conn: conn, operator: operator} do
      conn = get(conn, Routes.operator_path(conn, :edit, operator))
      assert html_response(conn, 200) =~ "Edit Operator"
    end
  end

  describe "update operator" do
    setup [:create_operator]

    test "redirects when data is valid", %{conn: conn, operator: operator} do
      conn = put(conn, Routes.operator_path(conn, :update, operator), operator: @update_attrs)
      assert redirected_to(conn) == Routes.operator_path(conn, :show, operator)

      conn = get(conn, Routes.operator_path(conn, :show, operator))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, operator: operator} do
      conn = put(conn, Routes.operator_path(conn, :update, operator), operator: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Operator"
    end
  end

  describe "delete operator" do
    setup [:create_operator]

    test "deletes chosen operator", %{conn: conn, operator: operator} do
      conn = delete(conn, Routes.operator_path(conn, :delete, operator))
      assert redirected_to(conn) == Routes.operator_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.operator_path(conn, :show, operator))
      end
    end
  end

  defp create_operator(_) do
    operator = operator_fixture()
    %{operator: operator}
  end
end
