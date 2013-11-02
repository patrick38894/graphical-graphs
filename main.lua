dofile "graph.lua"
require "math"

local g = graph()
local positions = {{x = 100, y= 100},{x = 200, y = 100},{x = 200, y = 200}}
for i,j in pairs(positions) do
	g[i] = vertex(j)
end
g[1]:connect(2,1)
g[2]:connect(3,1)




function love.mousepressed(x,y,button)
	local radius = 10
	for n,i in ipairs(g) do
		if math.sqrt(math.pow(x-i.data.x,2) + math.pow(y-i.data.y,2)) <= radius then
			selection = n
			i.color = {r = 0, g = 255, b = 0}
			break
		end
	end
end



function love.draw()
	g:draw()	
end
