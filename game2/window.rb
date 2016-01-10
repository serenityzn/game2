require 'gosu'
require './player_1.rb'
require './level.rb'
require './level_array.rb'

class GameWindow < Gosu::Window
	  def initialize
		  # Create main window
		  super 800, 600, :fullscreen => false
		  self.caption = "Mario type 2"

		  # Variables
		  @jump_flag = 0
		  @jump_hold =0
		  $in_air = 0
		  
		  # Cteate background
		  @background_image = Gosu::Image.new("media/1.png", :tileable => true)

		  # Create player 1
		  @player1 = Player1.new
		  @player1.warp(40,300)

		  #Create blocks array
		  @block = Array.new
		  @block.push(Gosu::Image.new(self, "media/block1.png", false))

		  #Create Level
		  @level = Level.new
	  end

	  # GAME main logic here
	  def update

		  if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
			  @player1.turn_left
		  end

		  if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
			  @player1.turn_right
		  end
		  
		  if button_down? Gosu::KbA and @jump_flag == 0 and $in_air == 0 then
			  @player1.jump
		  end
		  
		  if button_down? Gosu::KbQ then
			  @level.camera_l
		  end
		  
		  if button_down? Gosu::KbW then
			  @level.camera_r
		  end

		  @player1.move
	  end

	  def button_up(id)
		  if id == Gosu::KbA
			  @jump_flag = 0
		  end
		  if id == Gosu::KbC
			  @player1.gravity_off
		  end
		  if id == Gosu::KbS
			  @player1.accel_off
		  end
	  end

	  def button_down(id)
		  if id == Gosu::KbS
			  @player1.accel_on
		  end
	  end

	  # Here we need draw object which needed to redraw everything
	  def draw
		  @background_image.draw(0, 0, 0)
		  @level.draw(0,$levelarray,@block)
		  @player1.draw
	  end
end

window = GameWindow.new
window.show
