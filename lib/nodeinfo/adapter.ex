defmodule Nodeinfo.Adapter do
  @moduledoc """
  Contract for Nodeinfo module adapters
  """

  @adapter Application.get_env(:nodeinfo, :adapter)

  @callback base_url() :: String.t()
  defdelegate base_url(), to: @adapter

  @callback gather_nodeinfo_data() :: Nodeinfo.t()
  defdelegate gather_nodeinfo_data(), to: @adapter
end
