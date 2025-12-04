defmodule NodeinfoWeb.Router do
  defmacro __using__(_) do
    quote do
      pipeline :well_known_nodeinfo do
        plug(:accepts, ["json", "jrd+json"])
      end

      scope "/.well-known", NodeinfoWeb do
        pipe_through(:well_known_nodeinfo)

        get("/nodeinfo", NodeinfoController, :schemas)
      end

      scope "/", NodeinfoWeb do
        get("/.well-known/nodeinfo/:version", NodeinfoController, :nodeinfo)
        # Alias route for clients that expect /nodeinfo/:version
        get("/nodeinfo/:version", NodeinfoController, :nodeinfo)
      end
    end
  end
end
