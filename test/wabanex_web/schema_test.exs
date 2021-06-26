defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "rafael@banana.com", name: "Rafael", password: "132456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_reponse = %{
        "data" => %{
          "getUser" => %{
            "email" => "rafael@banana.com",
            "name" => "Rafael"
          }
        }
      }

      assert response == expected_reponse
    end
  end

    describe "users mutations" do
      test "when all params are valid, creates the user", %{conn: conn} do
        mutation = """
        mutation{
          createUser(input: {name: "Marcelino", email: "marcelino@email.com",password:"1234566"}){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Marcelino"}}} = response

    end
  end
end
