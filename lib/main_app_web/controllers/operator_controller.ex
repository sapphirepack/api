defmodule MainAppWeb.OperatorController do
  use MainAppWeb, :controller

  alias MainApp.Accounts
  alias MainApp.Accounts.Operator

  def new(conn, %{"handle" => handle, "server_key" => server_key}) do
    operator = Accounts.signup_operator(handle, server_key)
    case operator do
      nil -> conn |> put_status(:unprocessable_entity) |> html("")
      %Operator{} -> conn |> put_status(:ok) |> html("")
    end
  end

  def new(conn, _params) do
    conn |> put_status(:unprocessable_entity) |> html("")
  end
end
