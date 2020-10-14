defmodule Nodeinfo.Adapter do
  @moduledoc """
  Contract for Nodeinfo module adapters
  """

  @callback base_url() :: String.t()
  def base_url() do
    adapter = Application.get_env(:nodeinfo, :adapter)
    adapter.base_url()
  end

  @callback gather_nodeinfo_data() :: Nodeinfo.t()
  def gather_nodeinfo_data() do
    adapter = Application.get_env(:nodeinfo, :adapter)
    adapter.gather_nodeinfo_data()
  end
end
