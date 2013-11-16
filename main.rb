#!/usr/bin/env ruby

require 'date'
require 'sqlite3'
require 'sequel'



class Week

  attr_reader :days
    
    def initialize
      @days= Hash.new
      Date::DAYNAMES.each do |day|
        @days[day.downcase.to_sym] = Day.new
      end
    end
   
    def sort_lessons
      @days.each_value do |day|
        day.sort_lessons 
      end 
    end
    
    def save(path)
      
      db = Sequel.connect("sqlite://#{path}")
      db.create_table :lessons do
        primary_key :id
        Lesson.attr.each_key do |attr|
          String attr.to_sym
        end
        String :day
      end

      lessons = db[:lessons]
      @days.each do |dayname,day|
        day.lessons.each do |lesson|
          lesson[:day]=dayname.to_s
          lessons.insert lesson
          lesson.delete :day
        end
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

    def to_text
      text= String.new
      self.each do |key,value|
        text+=key.to_s 
        text+=':'
        text+=value.to_s
        text+=' '
      end
      text.chomp
    end

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
 
  def sort_lessons
    @lessons.sort! do |x,y|
      x[:starttime] <=> y[:starttime]
    end
  end

  def initialize
    @lessons = Array.new
  end
  
  def addlesson(lesson)
    @lessons.push lesson
  end

  def modlesson(id,lesson)
  end

  def rmlesson(lesson)
    @lessons.delete_if do |element|
      lesson.equal? element
    end
  end

end
