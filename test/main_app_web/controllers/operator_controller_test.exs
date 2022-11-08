defmodule MainAppWeb.OperatorControllerTest do
  use ExUnit.Case, async: true
  use MainAppWeb.ConnCase
  use Plug.Test

  alias MainAppWeb.Router

  @opts Router.init([])
  test 'signup with no paramters' do
    conn = conn(:post, "/api/20220720/new")
    response = Router.call(conn, @opts)
    assert response.status == 422
  end

  test 'signup with preexisting account' do
    conn = conn(:post, "/api/20220720/new", [handle: "mainaccount@example.org", server_key: "password"])
    _response = Router.call(conn, @opts)

    conn = conn(:post, "/api/20220720/new", [handle: "mainaccount@example.org", server_key: "password"])
    response1 = Router.call(conn, @opts)

    assert response1.status == 422
  end

  test 'signup without password' do
    conn = conn(:post, "/api/20220720/new", [handle: "mainaccount@example.com"])
    response = Router.call(conn, @opts)

    assert response.status == 422
  end

  test 'connect with no parameters' do
    conn = conn(:post, "/api/20220720/connect")
    response = Router.call(conn, @opts)
    assert response.status == 422
  end

  test 'connect with valid email and password' do
    conn = conn(:post, "/api/20220720/new", [handle: "mainaccount@example.org", server_key: "password"])
    _response = Router.call(conn, @opts)

    conn = conn(:post, "/api/20220720/connect", [handle: "mainaccount@example.org", server_key: "password"])
    response1 = Router.call(conn, @opts)

    assert String.length(Poison.decode!(response1.resp_body)["access_token"]) == 44
    assert String.length(Poison.decode!(response1.resp_body)["refresh_token"]) == 88
    assert Enum.count(Poison.decode!(response1.resp_body)) == 2
  end

  test 'reject connection with incorrect password' do
    conn = conn(:post, "/api/20220720/new", [handle: "mainaccount@example.org", server_key: "password"])
    _response = Router.call(conn, @opts)

    conn = conn(:post, "/api/20220720/connect", [handle: "mainaccount@example.org", server_key: "badpassword"])
    response1 = Router.call(conn, @opts)
    assert response1.status == 422
  end
end
