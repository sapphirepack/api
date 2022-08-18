defmodule MainAppWeb.OperatorController do
  use MainAppWeb, :controller

  alias MainApp.Accounts
  alias MainApp.Accounts.Operator

  def new(conn, _params) do
    changeset = Accounts.change_operator(%Operator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"operator" => operator_params}) do
    case Accounts.connect_operator(operator_params) do
      {:ok, operator} ->
        conn
        |> put_session(:current_user_id, operator.uuid)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {_error, %Ecto.Changeset{} = changeset} ->
        require IEx
        IEx.pry
        render(conn, "new.html", changeset: changeset)

      {:error, "Incorrect password"} ->
        changeset = Accounts.change_operator(%Operator{})
        conn
        |> put_flash(:info, "Incorrect password.")
        |> render("new.html", changeset: changeset)
    end
  end
end
