#!/usr/bin/env ruby

require 'date'
require 'gtk2'

require_relative 'gui.rb'


class Week

  attr_reader :days

    def initialize
      @days= Hash.new
      Date::DAYNAMES.each do |day|
        @days[day.downcase.to_sym] = Day.new
      end
    end

end

class Lesson < Hash
    
      @@attr=Hash.new
      @@attr[:name]=nil
      @@attr[:building]=nil
      @@attr[:room]=nil
      @@attr[:starttime]=nil
      @@attr[:endtime]=nil
      @@attr[:type]=nil
      @@attr[:examtype]=nil

    def self.attr
      @@attr
    end

    def initialize
      super
      self.replace @@attr
    end

end

class Day

  def initialize
    @lessons = Array.new
  end
  
  def addlesson(lesson)
    @lessons.push lesson
  end

  def modlesson(id,lesson)
  end

  def rmlesson(id)
  end

  def readlesson(id)
  end

end

week = Week.new
Gtk.init
  window = RubyApp.new
Gtk.main
