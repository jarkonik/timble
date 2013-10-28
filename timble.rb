#!/usr/bin/env ruby


require 'gtk2'

require_relative 'gui.rb'
require_relative 'main.rb'

week = Week.new
lesson = Lesson.new 
lesson[:name]="Test"
week.days[:sunday].addlesson(lesson)
lesson = Lesson.new
lesson[:name]="Test"
week.days[:saturday].addlesson(lesson)
lesson = Lesson.new
lesson[:name]="Test"
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.days[:wednesday].addlesson(lesson)
week.save 'test.db'
Gtk.init
  window = Interface.new
  window.updatelessons(week)
  window.show_all
Gtk.main
