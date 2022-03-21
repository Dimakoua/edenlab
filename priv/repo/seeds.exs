# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TestApp.Repo.insert!(%TestApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

TestApp.Repo.insert(%TestApp.Brands.Brand{name: "BMW"})
TestApp.Repo.insert(%TestApp.Brands.Brand{name: "Toyota"})
TestApp.Repo.insert(%TestApp.Brands.Brand{name: "Tesla"})
TestApp.Repo.insert(%TestApp.Brands.Brand{name: "Mercedes"})