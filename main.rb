#!/usr/bin/env ruby

require 'date'
require 'gtk2'
require 'sqlite3'

require_relative 'gui.rb'


class Week

  attr_reader :days

    def initialize
      @days= Hash.new
      Date::DAYNAMES.each do |day|
        @days[day.downcase.to_sym] = Day.new
      end
    end
    
    def save(path)
      db = SQLite3::Database.new path
      @days.each_key do |day|
        db.execute "CREATE TABLE #{day} ( name text(20), id int)"
      end
        db.execute 'INSERT INTO monday (name) VALUES ("test") '
	db.execute 'INSERT INTO monday (name) VALUES ("test") '
      puts db.execute( "select * from monday where name==\"test\"" )
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

  attr_reader :lessons   

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

end

