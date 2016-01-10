class Level
	def initialize
		@x = @y = 0
	end

	def draw(camx,level,blocks)
		 i = j = 0
		 while j <= $ar_y_l - 1
			 while i <= $ar_x_l - 1
				 if level[j][i].chr == "="
					 @x = i*40+20-$offset # Resolution 800x600
					 @y = j*40+20
					 @image = blocks[0]
					 @image.draw_rot(@x, @y, 1, 0)
				 end
				 i += 1
			 end
			 i = 0
			 j += 1
		 end

	end

	def camera_r
		puts "#{$offset}"
			$offset +=1
	end
	
	def camera_l
			$offset -=1
	end
end
