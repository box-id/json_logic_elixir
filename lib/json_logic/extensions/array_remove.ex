defmodule JsonLogic.Extensions.ArrayRemove do
  @moduledoc """
  Extension that provides the `array_remove` operator which removes specified items from an array.

  The operator accepts two arguments:
  - `array` (required): The source array to remove items from
  - `items` (required): Array of items to remove from the source array

  If either argument is not an array, it will be converted to a single-item array.
  If the source array is nil, an empty array will be returned.

  ## Why use array_remove?
  While removing elements could theoretically be accomplished using array operations like "filter",
  the execution context within a "filter" prevents the use of dynamic variables. This makes it
  impossible to reference external variables for the items to be removed.

  ## Examples

      iex> Logic.apply(%{
      ...>   "array_remove" => [
      ...>     [1, 2, 3, 4, 5],
      ...>     [2, 4]
      ...>   ]
      ...> })
      [1, 3, 5]

      iex> Logic.apply(%{
      ...>   "array_remove" => [
      ...>     %{"var" => "source"},
      ...>     %{"var" => "remove"}
      ...>   ]
      ...> }, %{
      ...>   "source" => ["apple", "banana", "cherry"],
      ...>   "remove" => ["banana"]
      ...> })
      ["apple", "cherry"]
  """
  @behaviour JsonLogic.Extension

  @impl true
  def operations do
    %{
      "array_remove" => :operation_array_remove
    }
  end

  @impl true
  def gen_code do
    quote do
      def operation_array_remove([source, items_to_remove], data) do
        source = __MODULE__.apply(source, data)
        items_to_remove = __MODULE__.apply(items_to_remove, data)

        # Convert inputs to lists if they aren't already
        source_list = to_list(source)
        remove_list = to_list(items_to_remove)

        # Remove all items in remove_list from source_list
        Enum.reject(source_list, &Enum.member?(remove_list, &1))
      end

      defp to_list(nil), do: []
      defp to_list(x) when is_list(x), do: x
      defp to_list(x), do: [x]
    end
  end
end
