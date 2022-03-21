defmodule TestApp.CarsTest do
  use TestApp.DataCase

  alias TestApp.Cars

  describe "cars" do
    alias TestApp.Cars.Car

    import TestApp.CarsFixtures
    import TestApp.BrandsFixtures

    @invalid_attrs %{body_type: nil, id: nil, is_electric: nil, model: nil, year: nil}

    test "list_cars/1 returns all cars" do
      car = car_fixture_with_brand()
      assert Cars.list_cars([]) == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      brand = brand_fixture()
      valid_attrs = %{body_type: :sedan, brand_id: brand.id, is_electric: true, model: "some model", year: 2015}

      assert {:ok, %Car{} = car} = Cars.create_car(valid_attrs)
      assert car.body_type == :sedan
      assert car.brand_id == brand.id
      assert car.is_electric == true
      assert car.model == "some model"
      assert car.year == 2015
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end


    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Cars.change_car(car)
    end
  end
end
