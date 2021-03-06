-- load mqtt library
local mqtt = require("mqtt")

-- create mqtt client
local client = mqtt.client{
	-- NOTE: this broker is not working sometimes; comment auth = {...} below if you still want to use it
	-- uri = "test.mosquitto.org",
	uri = "mqtt.flespi.io",
	-- NOTE: more about flespi tokens: https://flespi.com/kb/tokens-access-keys-to-flespi-platform
	auth = {username = "stPwSVV73Eqw5LSv0iMXbc4EguS7JyuZR9lxU5uLxI5tiNM8ToTVqNpu85pFtJv9"},
	clean = true,
}
print(client)

-- connect to broker, using assert to raise error on failure
assert(client:connect())
print("connected")

-- subscribe to test topic
assert(client:subscribe{
	topic = "luamqtt/#",
	qos = 1
})
print("subscribed")

-- publish
assert(client:publish{
	topic = "luamqtt/simpletest",
	payload = "hello",
	qos = 1
})
print("published")

-- receive one message and disconnect
client:on("message", function(msg)
	print("received message", msg)
	client:disconnect()
end)

-- start receive loop
assert(client:receive_loop())

print("done")
