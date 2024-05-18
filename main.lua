player = {}

mouse = {}
mouse.r = 0.8
mouse.g = 0.8
mouse.b = 0.8
mouse.linewidth = 1
mouse.isdown = false
mouse.lx = 0 -- lost x
mouse.ly = 0 -- lost y
mouse.x = 0
mouse.y = 0

entity = {}
entity.r = 1
entity.g = 0.3
entity.b = 0.1
entity.current = false
entity.x = 10
entity.y = 10
entity.w = 15
entity.h = 15

function love.load()
	for i = 1, 10 do 
		entity.x = love.math.random( 100, 500 )
		entity.y = love.math.random( 100, 500 )
	end
end


function love.draw() 
	love.graphics.setBackgroundColor( 1, 1, 1, 0.5 )
	love.graphics.setColor( 0.3, 0, 0, 1 )
	love.graphics.print( "lx: " .. tostring(mouse.lx) .. "	ly: ".. tostring(mouse.ly), 100, 100 );
	love.graphics.print( "x: " .. tostring(mouse.x) .. "	y: ".. tostring(mouse.y), 100, 120 );

	love.graphics.print( "ex: " .. tostring(entity.x) .. "	ex+w: ".. tostring(entity.x+entity.w), 100, 140 );
	love.graphics.print( "ey: " .. tostring(entity.y) .. "	ey+h: ".. tostring(entity.y+entity.h), 100, 160 );

	if mouse.isdown then
		love.graphics.setLineWidth( mouse.linewidth )
		love.graphics.setColor( mouse.r, mouse.g, mouse.b, 1 )
		love.graphics.rectangle( "line", mouse.lx, mouse.ly, mouse.x - mouse.lx, mouse.y - mouse.ly )
	end
	
	love.graphics.setColor( entity.r, entity.g, entity.b, 1 )
	love.graphics.rectangle( "fill", entity.x, entity.y, entity.w, entity.h )
	if entity.current then
		love.graphics.setLineWidth( mouse.linewidth )
		love.graphics.setColor( mouse.r, mouse.g, mouse.b, 1 )
		love.graphics.rectangle( "line", entity.x - 3, entity.y - 3, entity.w + 3*2, entity.h + 3*2 )
	end
end

function love.update( dt )
	if love.mouse.isDown( 1 ) then
		mouse.x = love.mouse.getX()
		mouse.y = love.mouse.getY()
	else
		mouse.isdown = false
	end

	mx = mouse.x;
	my = mouse.y;
	mlx = mouse.lx;
	mly = mouse.ly;
	ex = entity.x;
	ey = entity.y;
	ew = entity.w;
	eh = entity.h;
	ec = entity.current;

	if mouse.x - mouse.lx < 0 and mouse.y - mouse.ly > 0 then
		-- print( "nirx: " .. tostring(nir( mx, ex, mlx )) ) 
		-- print( "niry: " .. tostring(nir( mly, ey, my )) )

		print( "pir: " .. tostring(pir( ex, ey, mx, my, mlx, mly )) )

		if  pir( ex, ey, mlx, mly, mx, my ) then -- or pir( mx, my, ex, ey, ex + ew, ey + eh ) then
		-- if  nir( mouse.lx, entity.x, mouse.x ) and nir( mouse.ly, entity.y, mouse.y ) 
		-- 	or 
			-- nir( entity.x, mouse.x, entity.x + entity.w ) and nir( entity.y, mouse.y, entity.y + entity.h ) then
			entity.current = true
		else
			entity.current = false
		end
	elseif mouse.x - mouse.lx > 0 and mouse.y - mouse.ly < 0 then 

	elseif mouse.x - mouse.lx < 0 and mouse.y - mouse.ly < 0 then 

	else

	end

	-- if mouse.x - mouse.lx > 0 then
		
	-- elseif mouse.y - mouse.ly > 0 then
	-- 	if  nir( mouse.x, entity.x, mouse.lx ) and nir( mouse.y, entity.y, mouse.ly ) 
	-- 		or 
	-- 		nir( entity.x, mouse.x, entity.x + entity.w ) and nir( entity.y, mouse.y, entity.y + entity.h ) then
	-- 		entity.current = true
	-- 	else
	-- 		entity.current = false
	-- 	end
	-- end
end

function love.keypressed( key, scancode, isrepeat )
	if key == "escape" or key == "q" then
		love.event.quit();
	end
end

function love.mousepressed( x, y, button, istouch )
	if button == 1 then
		mouse.isdown = true
		mouse.lx = x
		mouse.ly = y
	end
end


-- Num in range
function nir( a, n, b )
	if a < n and n < b then
		return true
	end
	return false
end

-- Point in rectangle
function pir( px, py, x, y, x2, y2 )
	if nir( x, px, x2 ) and nir( y, py, y2 ) then
		return true
	end
	return false
end