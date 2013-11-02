dofile "graph.lua"
require "math"

local g = graph()


selection = nil

function love.mousepressed(x,y,button)
	local radius = 10
	if button == "l" then
		if selection then
			selection.color = {r = 255, g = 0, b = 0}
		end
		for _,i in pairs(g) do
			if math.sqrt(math.pow(x-i.data.x,2) + math.pow(y-i.data.y,2)) <= radius then
				selection = i
				i.color = {r = 0, g = 0, b = 255}
				return
			end
		end
		g:add({x=x,y=y})
	elseif button == "r" then 
		if not selection then
			return
		end
		for _,i in pairs(g) do
			local distance = math.sqrt(math.pow(x-i.data.x,2) + math.pow(y-i.data.y,2)) 
			if distance <= radius then
				selection:connect(i,distance)
				i:connect(selection,distance)
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
