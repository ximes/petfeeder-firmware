defmodule PetfeederApiWeb.PageController do
  use PetfeederApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
