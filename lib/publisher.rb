class Publisher < RedisPubSub

  # elixir subscriber part
  # def handle_out("new_msg", response, socket) do
  # %{body: json_str} = response
  # Logger.debug " #{inspect json_str}"
  # parsed_data = Poison.decode!(json_str)
  # Logger.debug " #{inspect parsed_data}"
  # push socket, "new_msg", parsed_data
  # {:noreply, socket}
  # end
  #
  def publish(_topic = nil, _event = nil, msg = {})

    _data = ::Erlang::Map[:__struct__, :payload,
                          @broadcast, Erlang::Map[msg], #msg, #Erlang::Map[msg],
                          :event, :topic,
                          _event, _topic] # 'new_msg' event and 'game:lobby' chanel
    tupple = ::Erlang::Tuple[1, @server_name, 1, :none, _topic, _data]
    @redis.publish @namespace, ::Erlang.term_to_binary(tupple)
  end

end
