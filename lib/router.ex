defmodule Myapp.Router do
    use Plug.Router # plugs: series of functions that a request routes through

    plug :match 
    plug :dispatch

    def start_link() do # Supervisor looks for start_link
        {:ok, _} = Plug.Adapters.Cowboy.http Myapp.Router, [], [port: 4000]
    end

    match _ do
        conn # this variable exists any time we accept a connection
            |> send_resp(404, "Not found")
            |> halt
    end

end