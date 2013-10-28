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

    def on_edit
      
      dialog = Gtk::Dialog.new("Message",
        $main_application_window,
        Gtk::Dialog::DESTROY_WITH_PARENT)
        
      
        Lesson.attr.each_key do |attr|
          dialog.vbox.add Gtk::Label.new attr.to_s.capitalize
          dialog.vbox.add Gtk::Entry.new
        end
        
        buttonbar = Gtk::HBox.new true, 3
        savebutton = Gtk::Button.new "Save"
        savebutton.set_size_request 80, 35
        cancelbutton = Gtk::Button.new "Cancel"
        cancelbutton.set_size_request 80, 35
        deletebutton = Gtk::Button.new "Delete"
        deletebutton.set_size_request 80, 35
        buttonbar.add savebutton
        buttonbar.add cancelbutton
        buttonbar.add deletebutton

        dialog.vbox.add buttonbar
      
      dialog.signal_connect('response') { dialog.destroy }
      
      dialog.show_all

   
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
   
        toolbar = Gtk::Toolbar.new
        new     = Gtk::ToolButton.new(Gtk::Stock::NEW)
        open     = Gtk::ToolButton.new(Gtk::Stock::OPEN)
        save    = Gtk::ToolButton.new(Gtk::Stock::SAVE)
        print     = Gtk::ToolButton.new(Gtk::Stock::PRINT)

        toolbar.insert(0, print)
        toolbar.insert(0, save)
        toolbar.insert(0, open)
        toolbar.insert(0, new)


        @dayboxes= Hash.new
        Date::DAYNAMES.each do |day|
          @dayboxes[day.downcase.to_sym] = Gtk::VBox.new false, 2
        end

        vbox = Gtk::VBox.new false, 2

        daynamesbar = Gtk::HBox.new true, 3
        Date::DAYNAMES.each do |day|
          daynamesbar.add Gtk::Label.new day
        end

        lessonsbar = Gtk::HBox.new true, 3
        @dayboxes.each_value do |daybox|
          dayboxframe = Gtk::Frame.new
          dayboxframe.add daybox
          lessonsbar.add dayboxframe
        end

        newclassbar = Gtk::HBox.new true, 3
        7.times do |day|
          newclassbutton = Gtk::Button.new("New class").set_size_request 80, 35
          newclassbutton.signal_connect "clicked" do
            on_edit
          end
          newclassbar.add newclassbutton
        end

        vbox.pack_start toolbar, false,false , 0
        vbox.pack_start daynamesbar, false,false , 0
        vbox.pack_start newclassbar, false,false , 0
        vbox.pack_start lessonsbar, true,true , 0
        add vbox

        window = Gtk::Window::POPUP

     end
end
