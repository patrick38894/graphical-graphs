dofile "graph.lua"
require "math"

function love.load()
	g = graph()
	selection = nil
	selection2 = nil
end

function love.mousepressed(x,y,button)
	local radius = 10
	if button == "l" then
		if selection and not love.keyboard.isDown("lshift")then
			for _,i in ipairs(g) do
				i.color = {r=255,g=0,b=0}
			end
			selection = nil
			selection2 = nil
		end
		for _,i in ipairs(g) do
			if math.sqrt(math.pow(x-i.data.x,2) + math.pow(y-i.data.y,2)) <= radius then
				if not love.keyboard.isDown("lshift") then
					selection = i
					i.color = {r = 0, g = 0, b = 255}
				else
					selection2 = i
					i.color = {r = 0, g = 255, b = 0}
					g:shortest_path(selection,i)
				end
				return
			end
		end
		g:add({x=x,y=y})
	elseif button == "r" then 
		if not selection then
			return
		end
		for _,i in ipairs(g) do
			local distance = math.sqrt(math.pow(x-i.data.x,2) + math.pow(y-i.data.y,2)) 
			if distance <= radius then
				selection:connect(i,distance)
				i:connect(selection,distance)
				g:update_matrices()
				return
			end
		end
	end
end


function love.draw()
	g:draw()	
end

function love.update(dt)
end

function love.keypressed(key, isrepeat)
	if key == "return" then
		g:showall()
		g:update_matrices()
	end
	if key == "escape" then
		g = graph()
	end
end

