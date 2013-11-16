#!/usr/bin/env ruby

require_relative 'gui.rb'
require_relative 'main.rb'


week = Week.new

Gtk.init
  window = Interface.new(week)
  window.updatelessons(week)
  window.clearlessons
  window.updatelessons(week)
  window.show_all
Gtk.main
