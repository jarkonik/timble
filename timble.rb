#!/usr/bin/env ruby

require_relative 'gui.rb'
require_relative 'main.rb'


#TESTING:
week = Week.new
lesson = Lesson.new
lesson[:name]="Test"
lesson[:building]="b2"
lesson[:room]="101"
week.days[:saturday].addlesson(lesson)

Gtk.init
  window = Interface.new(week)
  window.updatelessons(week)
  window.clearlessons
  window.updatelessons(week)
  window.show_all
Gtk.main
