defmodule MainAppWeb.OperatorController do
  use MainAppWeb, :controller

  alias MainApp.Accounts
  alias MainApp.Accounts.Operator
  alias MainApp.Session

  def new(conn, %{"handle" => handle, "server_key" => server_key, "salt" => salt}) do
    operator = Accounts.signup_operator(handle, server_key, salt)
    case operator do
      nil -> conn |> put_status(:unprocessable_entity) |> html("")
      %Operator{} -> conn |> put_status(:ok) |> html("")
    end
  end

  def new(conn, _params) do
    conn |> put_status(:unprocessable_entity) |> html("")
  end

  def login(conn, %{"handle" => handle,"server_key" => server_key}) do
    operator = Accounts.login_operator(handle, server_key)
    case operator do
      nil -> conn |> put_status(:unprocessable_entity) |> html("")

      %Operator{} -> conn |> render("index.json", Session.login(operator))
    end

  end

  def login(conn, _params) do
    conn |> put_status(:unprocessable_entity) |> html("")
  end

  def salt(conn, %{"handle" => handle}) do
    saltRetrieved = Accounts.seed_operator(handle)
    case saltRetrieved do
      nil -> conn |> put_status(:not_found) |> html("")
      _ -> conn |> render("salt.json", %{"salt": saltRetrieved})
    end
  end
end
