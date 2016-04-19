require 'rubygems'
require 'json'
require 'redis' #https://github.com/redis/redis-rb gem redis
require 'erlang/terms' #https://github.com/potatosalad/erlang-terms gem 'erlang-terms'
require "stringio"
require 'erlang/etf' # gem 'erlang-etf', require: 'erlang/etf'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/redis_pub_sub'
require 'lib/publisher'


trap(:INT) { puts; exit }
redis = Redis.new
publisher = Publisher.new(redis: redis,
                          server_name: 'ruby_example_server')
h = {body: {time: "22;33;44", body: "test-string", username: 'u1'}.to_json}
publisher.publish("game:lobby", "new_msg", h)

#
# begin
#   redis.subscribe(:one, :two) do |on|
#     on.subscribe do |channel, subscriptions|
#       puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
#     end
#
#     on.message do |channel, message|
#       puts "##{channel}: #{message}"
#       redis.unsubscribe if message == "exit"
#     end
#
#     on.unsubscribe do |channel, subscriptions|
#       puts "Unsubscribed from ##{channel} (#{subscriptions} subscriptions)"
#     end
#   end
# rescue Redis::BaseConnectionError => error
#   puts "#{error}, retrying in 1s"
#   sleep 1
#   retry
# end
#
#
