defmodule NodeinfoWeb.NodeinfoController do
  use NodeinfoWeb, :controller
  alias Nodeinfo.Adapter

  def schemas(conn, _params) do
    response = %{
      links: [
        %{
          rel: "http://nodeinfo.diaspora.software/ns/schema/2.0",
          href: Adapter.base_url() <> "/.well-known/nodeinfo/2.0"
        },
        %{
          rel: "http://nodeinfo.diaspora.software/ns/schema/2.1",
          href: Adapter.base_url() <> "/.well-known/nodeinfo/2.1"
        }
      ]
    }

    json(conn, response)
  end

  def raw_nodeinfo(data) do
    %{
      version: "2.0",
      software: %{
        name: data.app_name |> String.downcase(),
        version: data.app_version
      },
      protocols: ["activitypub"],
      services: %{
        inbound: [],
        outbound: []
      },
      openRegistrations: data.open_registrations,
      # currently have no good way to get total post count
      usage: %{
        users: %{
          total: data.user_count
        }
      },
      metadata: %{
        nodeName: data.node_name,
        nodeDescription: data.node_description,
        federation: data.federating
      }
    }
  end

  def nodeinfo(conn, %{"version" => "2.0"}) do
    data = Adapter.gather_nodeinfo_data()

    conn
    |> put_resp_header(
      "content-type",
      "application/json; profile=http://nodeinfo.diaspora.software/ns/schema/2.0#; charset=utf-8"
    )
    |> json(raw_nodeinfo(data))
  end

  def nodeinfo(conn, %{"version" => "2.1"}) do
    data = Adapter.gather_nodeinfo_data()
    raw_response = raw_nodeinfo(data)

    updated_software =
      raw_response
      |> Map.get(:software)
      |> Map.put(:repository, data.app_repository)

    response =
      raw_response
      |> Map.put(:software, updated_software)
      |> Map.put(:version, "2.1")

    conn
    |> put_resp_header(
      "content-type",
      "application/json; profile=http://nodeinfo.diaspora.software/ns/schema/2.1#; charset=utf-8"
    )
    |> json(response)
  end

  def nodeinfo(conn, _) do
    json(conn, %{"error" => "Nodeinfo schema version not handled"})
  end
end
