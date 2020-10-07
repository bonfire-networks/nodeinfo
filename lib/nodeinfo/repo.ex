defmodule Nodeinfo.Repo do
  use Ecto.Repo,
    otp_app: :nodeinfo,
    adapter: Ecto.Adapters.Postgres
end
