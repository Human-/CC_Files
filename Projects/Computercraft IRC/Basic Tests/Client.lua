local serverID = 1
local rSide = "top"

local function recv()
  while true do
    id, msg = rednet.receive()
    if id == serverID then
      print(msg)
    end
  end
end

local function sen()
  write("> ")
  input = read()
  rednet.send(serverID, input)
end

local function reset()
  rednet.open(rSide)
  term.clear()
  term.setCursorPos(1,18)
end

local function connect()
  rednet.send(serverID, "connect")
  id, msg = rednet.receive(1)
  if id == serverID then
    if msg == "connected" then
      print("Connected!")
    else
      print("Could not connect!")
      sleep(2)
      term.clear()
      term.setCursorPos(1,1)
      shell.run("shell")
    end
  end
end

reset()
connect()
parallel.waitForAny(sen,recv)