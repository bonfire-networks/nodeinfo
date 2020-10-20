defmodule Nodeinfo do
  @moduledoc """
  Nodeinfo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defstruct [:app_name, :app_version, :open_registrations, :user_count, :node_name, :node_description, :federating, :app_repository]
end
