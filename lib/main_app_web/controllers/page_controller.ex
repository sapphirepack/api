defmodule MainAppWeb.PageController do
  use MainAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
