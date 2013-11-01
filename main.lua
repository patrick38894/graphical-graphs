dofile "graph.lua"

local g = graph()
local positions = {{x = 100, y= 100},{x = 200, y = 100},{x = 200, y = 200}}
for i,j in pairs(positions) do
	g[i] = vertex(j)
end
g[1]:connect(2,1)
g[2]:connect(3,1)






function love.draw()
	g:draw()	
end
