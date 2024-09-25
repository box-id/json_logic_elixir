defmodule JsonLogic.Extensions.EncodeJson do
  @moduledoc """
  This module provides the `encode_json` and `encode_json_obj` operation for JsonLogic.
  They are used to encode a lists to a json string. Depending on which operation is used, the output will be either a json array or a json object.
  The obj module must be included to use this extension.

  ## Examples encode json

      iex> Logic.apply(%{
      ...>   "encode_json" => [
      ...>     ["key1", "foo", "key2", 42],
      ...>   ]
      ...> })
      ~s'["key1","foo","key2",42]'


  ## Examples encode json obj

      iex> Logic.apply(%{
      ...>   "encode_json_obj" => [
      ...>     ["key1", "foo"],
      ...>     ["key2", 42],
      ...>   ]
      ...> })
      ~s'{"key1":"foo","key2":42}'

  """

  @behaviour JsonLogic.Extension

  require Logger

  def operations,
    do: %{
      "encode_json" => :operation_encode_json,
      "encode_json_obj" => :operation_encode_json_obj
    }

  def gen_code do
    quote do
      require Logger

      def operation_encode_json(args, data) do
        args
        |> __MODULE__.apply(data)
        |> Jason.encode!()
      end

      def operation_encode_json_obj(args, data) do
        %{"obj" => args}
        |> __MODULE__.apply(data)
        |> Jason.encode!()
      end
    end
  end
end
