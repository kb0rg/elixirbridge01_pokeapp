defmodule Myapp.Router do
    use Plug.Router # plugs: series of functions that a request routes through

    plug :match 
    plug :dispatch

    def start_link() do # Supervisor looks for start_link
        {:ok, _} = Plug.Adapters.Cowboy.http Myapp.Router, [], [port: 4000]
    end

    get "/hello" do
        conn
        |> put_resp_header("content-type", "text/html")
        |> send_resp(200, "Hello!")
    end

    get "/" do
        rand_poke = :rand.uniform(248)
        {:ok, pokemon} = Myapp.ApiServer.get_pokemon(rand_poke)

        locals = [
            name: 'kborg',
            pokemon: pokemon
        ]

        page = EEx.eval_file("templates/home.html", locals)

        conn
        |> put_resp_header("content-type", "text/html")
        |> send_resp(200, page)
    end

    match _ do
        conn # this variable exists any time we accept a connection
            |> send_resp(404, "Not found")
            |> halt
    end
end