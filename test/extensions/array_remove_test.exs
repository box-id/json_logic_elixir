defmodule Extensions.ArrayRemoveTest do
  use ExUnit.Case, async: true

  defmodule Logic do
    use JsonLogic.Base,
      extensions: [
        JsonLogic.Extensions.ArrayRemove
      ]
  end

  doctest JsonLogic.Extensions.ArrayRemove, import: Logic

  describe "operation array_remove" do
    test "removes items from array with direct values" do
      assert [1, 3, 5] ==
               Logic.apply(%{
                 "array_remove" => [
                   [1, 2, 3, 4, 5],
                   [2, 4]
                 ]
               })
    end

    test "removes items from array using variables" do
      assert ["apple", "cherry"] ==
               Logic.apply(
                 %{
                   "array_remove" => [
                     %{"var" => "fruits"},
                     %{"var" => "remove"}
                   ]
                 },
                 %{
                   "fruits" => ["apple", "banana", "cherry"],
                   "remove" => ["banana"]
                 }
               )
    end

    test "handles non-array inputs" do
      assert [1, 3] ==
               Logic.apply(%{
                 "array_remove" => [
                   [1, 2, 3],
                   2
                 ]
               })

      assert [] ==
               Logic.apply(%{
                 "array_remove" => [
                   1,
                   1
                 ]
               })
    end

    test "handles nil inputs" do
      assert [] ==
               Logic.apply(%{
                 "array_remove" => [
                   nil,
                   [1, 2]
                 ]
               })

      assert [1, 2, 3] ==
               Logic.apply(%{
                 "array_remove" => [
                   [1, 2, 3],
                   nil
                 ]
               })
    end

    test "handles empty arrays" do
      assert [] ==
               Logic.apply(%{
                 "array_remove" => [
                   [],
                   [1, 2]
                 ]
               })

      assert [1, 2, 3] ==
               Logic.apply(%{
                 "array_remove" => [
                   [1, 2, 3],
                   []
                 ]
               })
    end
  end
end 