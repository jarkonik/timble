#!/usr/bin/env ruby

require 'gtk2'

require_relative 'gui.rb'
require_relative 'main.rb'

week = Week.new
Gtk.init
  window = RubyApp.new
Gtk.main
