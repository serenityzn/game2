class Player1
	def initialize
		@image = Gosu::Image.new("media/mushroom.png")
		@x = @y = @force = @cam_ac = 0
		@scroll = 0
		@score = 0
		@step = @speed =3 
		@gravity = 3
		@friction = 1
		@jump = 33
		@height = 160
		@accel = 0
		@velocity_x = @velocity_y = 0
	end

	def gravity_off
		@gravity = 0
		@force = 0
	end

	def accel_on
		@accel = 5
		@cam_ac = 5
	end

	def accel_off
		@accel = 0
		@cam_ac = 0
	end

	def warp(x,y)
		@x, @y = x, y
	end

	def turn_left
		@scroll = 0
		if @x > 400
			@step = $off_step
		end
		if $in_air == 0
				@velocity_x = -1*(@step + @accel)
		end
		@friction = -1
	end

	def turn_right
		if @x > 400 and @scroll == 0
			$off_step = @speed + @cam_ac
			@accel = 0
			@step = 0
			@scroll = 1
			$offset += @x - 400
		end

		if @scroll == 1
			$offset +=$off_step
			@accel = 0
			@step = 0
		end

		if $in_air == 0
				@velocity_x = @step + @accel
		end
		@friction = 1
	end

	def jump
		@velocity_y = -1*@jump
		$in_air = 1
	end

	def draw
		@image.draw_rot(@x, @y, 1, 0)
	end

	def move
		if @velocity_x != 0 and $in_air==0
				@velocity_x -=@friction
		end

		if @velocity_y < 0
			@velocity_y += @gravity
		else
			@velocity_y = @gravity
		end

		if y_direction(@velocity_y) == 1
			if check_ground(@velocity_x,@velocity_y) == 0
				@force = 0
			else
				$in_air = 0
				@force = -1 * @gravity
			end
		end

		if check_r(@velocity_x) == 0
			@x += @velocity_x
		else
			@velocity_x = 0
		end
		#puts "#{@velocity_y}"
		@y += @velocity_y+@force
	end

	def check_r(x) # return 0 if free, 1 if block
		newx = @x + x + $offset
		if $levelarray[@y/40][(newx+20)/40] != " " or $levelarray[@y/40][(newx-20)/40] != " "
			res = 1
		else 
			res = 0
		end
		return res
	end
	
	def check_l(x) # return 0 if free, 1 if block
		newx = @x + x + $offset
		if $levelarray[@y/40][(newx-20)/40] != " "
			res = 1
		else 
			res = 0
		end
		return res
	end

	def check_ground(x,y)
		res = 0
		x += @x + $offset
		y += @y
		if $levelarray[(y+20)/40][x/40] != " "
			res = 1
		end
		
	return res
	end

	def y_direction(y) # return 1 if fall, 0 if jump
		new_y = @y+y
		if new_y - @y > 0
			res = 1
		else
			res = 0
		end

		return res
	end
end
