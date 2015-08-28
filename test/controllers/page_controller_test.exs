defmodule Picnic.PageControllerTest do
  use Picnic.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "id=\"chat\""
  end
end
