defmodule Myapp.APISErver do
    use GenServer
    def init() do
        {:ok, []}
    end

    def start_link(_,_) do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    def handle_call(_term, _pid, state) do
        {:reply, [], state}
    end

    def handle_cast(_term, state) do
        {:noreply, state}
    end

    def terminate() do
        :ok
    end
end