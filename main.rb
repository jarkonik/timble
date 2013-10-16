#!/usr/bin/env ruby

require 'date'
require 'gtk2'


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

class RubyApp < Gtk::Window

    def initialize
        super
    
        set_title "Center"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end
        
        init_ui         

        set_size_request 640,480

        set_window_position Gtk::Window::POS_CENTER
        
        show_all
    end

     def init_ui
        vbox = Gtk::VBox.new false, 2

        editbar = Gtk::HBox.new true, 3
        Lesson.attr.each_key do |attr|
          editbar.add Gtk::Label.new attr.to_s.capitalize 
          editbar.add Gtk::Entry.new
        end

        daynamesbar = Gtk::HBox.new true, 3
        Date::DAYNAMES.each do |day| 
          daynamesbar.add Gtk::Label.new day
        end

        buttonbar = Gtk::HBox.new true, 3
        savebutton = Gtk::Button.new "Save"
	savebutton.set_size_request 80, 35 
        deletebutton = Gtk::Button.new "Delete"
        deletebutton.set_size_request 80, 35
        buttonbar.add savebutton
        buttonbar.add deletebutton

        lessonsbar = Gtk::HBox.new true, 3
        7.times do |day|
          daybox = Gtk::VBox.new(false,0)
          dayboxframe= Gtk::Frame.new 
          stringg = "Test"
          lesson = Gtk::Button.new(stringg).modify_bg(Gtk::STATE_NORMAL,Gdk::Color.new(0,0,65535))
          lesson.set_size_request 80,100 
          lessonsalignment = Gtk::Alignment.new 0, 0,1,0
          daybox = Gtk::VBox.new(false,0)
          dayboxframe.add lessonsalignment
          lessonsalignment.add lesson
          lessonsbar.add dayboxframe
        end
   
        newclassbar = Gtk::HBox.new true, 3
        7.times do |day|
          newclassbar.add Gtk::Button.new("New class").set_size_request 80, 35
        end

        vbox.pack_start daynamesbar, false,false , 0
        vbox.pack_start newclassbar, false,false , 0
        vbox.pack_start lessonsbar, true,true , 0
        vbox.pack_start editbar, false, false, 0
        vbox.pack_start buttonbar, false,false , 0

        add vbox
     end
end
week = Week.new
Gtk.init
  window = RubyApp.new
Gtk.main
