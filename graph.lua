require "math"

graphmt = {}
graphmt.__index = graphmt

vertexmt = {}
vertexmt.__index = vertexmt

vertex = function(data)
	local v = {}
	v.data = data
	v.color = {r = 255, g = 0, b = 0}
	v.visit = false
	v.edges = {}
	return setmetatable(v,vertexmt)
end

function vertexmt:connect(dest, cost)
	self.edges[#self.edges+1] = {}
	self.edges[#self.edges].dest = dest
	self.edges[#self.edges].cost = cost
end

graph = function()
	local g = {}
	return setmetatable(g,graphmt)
end

function graphmt:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.clear()
	local radius = 10
	for _,i in pairs(self) do
		if i == nil or i.data == nil then
			print("null node or data error")
			return
		end
		i.visit = true
		love.graphics.setColor(0,0,0)
		for _,j in pairs(i.edges) do
			if self[j.dest].visit == false then
				love.graphics.line(i.data.x, i.data.y, self[j.dest].data.x, self[j.dest].data.y)
			end
		end
		love.graphics.setColor(i.color.r, i.color.g, i.color.b)
		love.graphics.circle("fill",i.data.x,i.data.y,radius, 50);
	end
	for _,i in pairs(self) do
		i.visit = false
	end
end

