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
    @lessons.append lesson
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

        set_default_size 250, 200
        set_window_position Gtk::Window::POS_CENTER
        
        show_all
    end

     def init_ui
        vbox = Gtk::VBox.new false, 2

        hbox2 = Gtk::HBox.new true, 3
        Lesson.attr.each_key do |attr|
          hbox2.add Gtk::Label.new attr.to_s.capitalize 
          hbox2.add Gtk::Entry.new
        end

        hbox3 = Gtk::HBox.new true, 3
        Date::DAYNAMES.each do |day| 
          hbox3.add Gtk::Label.new day
        end

        hbox4 = Gtk::HBox.new true, 3
        hbox4.add Gtk::Button.new 

        buttonbar = Gtk::Alignment.new 1, 1,1,1
        buttonbar.add hbox4

        daysbar = Gtk::Alignment.new 1, 0,1,0
        daysbar.add hbox3
       
        editbar = Gtk::Alignment.new 1, 0,1,0
        editbar.add hbox2 

        vbox.pack_start daysbar, true,true , 0
        vbox.pack_start editbar, false, false, 0
        vbox.pack_start buttonbar, false, false, 0
        
        add vbox
     end

end
week = Week.new
Gtk.init
  window = RubyApp.new
Gtk.main


