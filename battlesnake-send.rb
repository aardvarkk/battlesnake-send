#!/usr/bin/env ruby

require 'curses'
include Curses

noecho
init_screen
timeout = 0
stdscr.keypad = true

loop do
	k = getch
	setpos 0,0
	clrtoeol
	case k
	when KEY_UP
		addstr "up"
	when KEY_DOWN
		addstr "down"
	when KEY_LEFT
		addstr "left"
	when KEY_RIGHT
		addstr "right"
	end
	refresh
end
