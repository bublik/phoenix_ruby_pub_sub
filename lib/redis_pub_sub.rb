class RedisPubSub

  attr_accessor :server_name
  attr_accessor :namespace #:name	The required name to register the PubSub processes, ie: MyApp.PubSub
  attr_accessor :broadcast
  attr_accessor :topic
  attr_accessor :event

  def initialize(options = {redis: nil, namespace: nil, broadcast: nil})
    @redis = options[:redis]
    @namespace = options[:namespace] || 'phx:Elixir.Ph2.PubSub'
    @broadcast = (options[:broadcast] || 'Elixir.Phoenix.Socket.Broadcast').to_sym
    @server_name = options[:server_name] || 'ruby_server_name'
  end

end