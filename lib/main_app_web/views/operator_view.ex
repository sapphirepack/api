defmodule MainAppWeb.OperatorView do
  use MainAppWeb, :view
  alias MainAppWeb.Router.Helpers, as: Routes

  def render("index.json", %{access_token: access_token, refresh_token: refresh_token}) do # [access_token, refresh_token]
    %{access_token: access_token, refresh_token: refresh_token}
  end
end
