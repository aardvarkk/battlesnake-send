#!/usr/bin/env ruby

require 'curses'
require 'json'
require 'optparse'
require 'net/http'

OptionParser.new do |opts|
  opts.on('-h h', '--host h', 'Host to send to') do |host|
    $host = host
  end
  opts.on('-p p', '--port p', 'Port to send to') do |port|
    $port = port
  end
end.parse!

include Curses

noecho
init_screen
timeout = 0
stdscr.keypad = true

def send_dir(dir)
	addstr dir

	req = Net::HTTP::Post.new('/set_move', 'Content-Type' => 'application/json')
	req.body = { move: dir }.to_json
	res = Net::HTTP.start($host, $port) do |http|
  	http.request(req)
	end
end

loop do
	k = getch
	setpos 0,0
	clrtoeol
	case k
	when KEY_UP
		send_dir "up"
	when KEY_DOWN
		send_dir "down"
	when KEY_LEFT
		send_dir "left"
	when KEY_RIGHT
		send_dir "right"
	end
	refresh
end
