#!/usr/bin/env ruby

require 'gtk2'

class Interface < Gtk::Window

    @dayboxes

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
  
    def updatelessons(week)
      week.days.each do |dayname,day|  
        day.lessons.each do |lessonmem|
          lesson = Gtk::Button.new("Test").modify_bg(Gtk::STATE_NORMAL,Gdk::Color.new(0,0,65535))
          lesson.set_size_request 80,100
          lessonsalignment = Gtk::Alignment.new 0, 0,1,0
          lessonsalignment.add lesson
          @dayboxes[dayname].add lessonsalignment
          
        end
      end
    end

    def init_ui

        @dayboxes= Hash.new
        Date::DAYNAMES.each do |day|
          @dayboxes[day.downcase.to_sym] = Gtk::VBox.new false, 2
        end

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
        @dayboxes.each_value do |daybox|
          dayboxframe = Gtk::Frame.new
          dayboxframe.add daybox
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
