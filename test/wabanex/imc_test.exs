defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_reponse =
        {:ok,
          %{
            "Dani" => 23.437499999999996,
            "Diego" => 23.04002019946976,
            "Gabu" => 22.857142857142858,
            "Rafael" => 23.93948099205209,
            "Rodrigo" => 21.91358024691358
            }
        }

      assert response == expected_reponse
    end

    test "when the wrong file name is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_reponse = {:error, "Error while opening the file"}

      assert response == expected_reponse
    end
  end
end
