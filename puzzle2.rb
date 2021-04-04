require 'gtk3'
require 'thread'
require 'rfid_rc522'

class RubyApp < Gtk::Window

    def initialize
        super
    
			set_title  "Puzzle 2"
			signal_connect "destroy" do 
            Gtk.main_quit 
        end
        
        set_border_width 10

		#CREEM UN GRID
		grid = Gtk::Grid.new
		add(grid)
		
		#Creem un label
        @label = Gtk::Label.new 
        @label.set_text("Please, login with your university card")
		grid.attach(@label,0,0,1,1) 
		@label.set_size_request(500,100)
		@label.override_background_color(0 , Gdk::RGBA::new(0, 0, 1.0, 1.0)) #Color blau
		@label.override_color(0 , Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))	#Color blanc 
		
		
		#Creem el botó clear
		button = Gtk::Button.new(:label => "Clear")
		button.signal_connect("clicked") do
			info_label.set_markup("Please, login with your university card")
			rc522
		end
		
		#Col·loquem la finestra al centre de la pantalla
        set_window_position(:center)   
        
        thr = Thread.new {rc522}
		    
        show_all
        Gtk.main
        thr.join
        
    end
    

    def rc522
	    	thr = Thread.new{
		rf = Rfid_rc522.new
		uid = rf.read_uid
		@label.set_text("uid #{uid}")
		@label.override_background_color(0 , Gdk::RGBA::new(1.0, 0, 0, 1.0)) #Color vermell
			}
		       		
    end
    
    def clear
		
		
		@label.set_text("Please, login with your university card")
		@label.override_background_color(0 , Gdk::RGBA::new(0, 0, 1.0, 1.0)) #Color blau		
		hr=Thread.new {rc522}

    end
end


    window = RubyApp.new
  
