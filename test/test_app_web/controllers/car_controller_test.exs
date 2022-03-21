defmodule TestAppWeb.CarControllerTest do
  use TestAppWeb.ConnCase

  import TestApp.BrandsFixtures

  @create_attrs %{body_type: :sedan, is_electric: true, model: "some model", year: 2012}
  @invalid_attrs %{body_type: nil, id: nil, is_electric: nil, model: nil, year: nil}
  @invalid_enum %{body_type: :sedan_sedan, is_electric: true, model: "some model", year: 2012}
  @invalid_year %{body_type: :sedan, is_electric: true, model: "some model", year: 24}

  describe "index" do
    test "lists all cars", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :index))
      assert %{"data" => []} == json_response(conn, 200)
    end

    test "lists filtered cars", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :index), bran: "BMW", body_type: "sedan", is_electric: true)
      assert %{"data" => []} == json_response(conn, 200)
    end
  end


  describe "create car" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), get_attrs_with_brand(@create_attrs))
      assert json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), @invalid_attrs)

      assert %{"error" => %{"invalid" => [%{"entry" => "brand_id", "entry_type" => "uuid", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]}, %{"entry" => "model", "entry_type" => "string", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]}, %{"entry" => "year", "entry_type" => "integer", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]}, %{"entry" => "body_type", "entry_type" => "enum", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]}, %{"entry" => "is_electric", "entry_type" => "boolean", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]}]}}
      == json_response(conn, 422)
    end

    test "renders errors when year is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), get_attrs_with_brand(@invalid_year))

      assert %{"error"=>%{"invalid"=>[%{"entry"=>"year", "entry_type"=>"integer", "rules"=>[%{"description"=>"is invalid", "validation"=>"inclusion", "values"=>%{"from"=>1886, "to"=>2022}}]}]}} == json_response(conn, 422)
    end

    test "renders errors when enum is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), get_attrs_with_brand(@invalid_enum))

      assert %{"error"=>%{"invalid"=>[%{"entry"=>"body_type", "entry_type"=>"enum", "rules"=>[%{"description"=>"is invalid", "validation"=>"subset", "values"=>"sedan,coupe,pickup,minivan,cuv"}]}]}} == json_response(conn, 422)
    end

    test "renders errors when brand_id is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), Map.put(@create_attrs, :brand_id, "aa-aa-aa"))

      assert  %{"error"=>%{"invalid"=>[%{"entry"=>"brand_id", "entry_type"=>"uuid", "rules"=>[%{"description"=>"is invalid", "validation"=>"exists"}]}]}} == json_response(conn, 422)
    end
  end

  defp get_attrs_with_brand(attrs) do
    brand = brand_fixture()
    Map.put(attrs, :brand_id, brand.id)
  end
end
