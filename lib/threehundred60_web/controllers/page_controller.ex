defmodule Threehundred60Web.PageController do
  use Threehundred60Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
