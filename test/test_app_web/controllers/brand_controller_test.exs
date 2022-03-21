defmodule TestAppWeb.BrandControllerTest do
  use TestAppWeb.ConnCase

  describe "index" do
    test "lists all brands", %{conn: conn} do
      conn = get(conn, Routes.brand_path(conn, :index))
      assert %{"data" => []} == json_response(conn, 200)
    end
  end
end
