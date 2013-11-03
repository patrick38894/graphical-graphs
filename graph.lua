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
	for _,i in pairs(self.edges) do
		if i.dest == dest then
			return
		end
	end
	self.edges[#self.edges+1] = {}
	self.edges[#self.edges].dest = dest
	self.edges[#self.edges].cost = cost
end

graph = function()
	local g = {}
	g.eq_matrix = {}
	g.cost_matrix = {}
	return setmetatable(g,graphmt)
end

function graphmt:add(data)
	self[#self+1] = vertex(data)
	self:update_matrices()
end

function graphmt:update_matrices()
	self.eq_matrix = {}
	for i in ipairs(self) do
		self.eq_matrix[i] = {}
		for j in ipairs(self) do
			for _,k in ipairs(self[i].edges) do
				self.eq_matrix[i][j] = false
				if k.dest == self[j] then
					self.eq_matrix[i][j] = true
					break
				end
			end
		end
	end

	for i in ipairs(self.eq_matrix) do
		for j in ipairs(self.eq_matrix) do
			for k in ipairs(self.eq_matrix) do
				if self.eq_matrix[j][i] and self.eq_matrix[i][k] then
					self.eq_matrix[j][k] = true
				end
			end
		end
	end
end

function graphmt:showmatrix() 
	for i in ipairs(self.eq_matrix) do
		local tempstr = " "
		for j in ipairs(self.eq_matrix[i]) do
			if self.eq_matrix[i][j] then
				tempstr = tempstr .. "1 "
			else
				tempstr = tempstr .. "0 "
			end
		end
		print(tempstr)
	end
end

function graphmt:showall()
	self:update_matrices()
	self:showmatrix()
	print("showing all equivalencies")
	for i in ipairs(self.eq_matrix) do
		for j in ipairs(self.eq_matrix[i]) do
			if self.eq_matrix[i][j] then
				self[i]:connect(self[j],999)
			end
		end
	end
end

function graphmt:shortest_path(start,finish)
	

end

function graphmt:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.clear()
	local radius = 10
	for _,i in ipairs(self) do
		if i == nil or i.data == nil then
			print("null node or data error")
			return
		end
		i.visit = true
		love.graphics.setColor(0,0,0)
		for _,j in pairs(i.edges) do
			if j.dest.visit == false then
				love.graphics.line(i.data.x, i.data.y, j.dest.data.x, j.dest.data.y)
			end
		end
		love.graphics.setColor(i.color.r, i.color.g, i.color.b)
		love.graphics.circle("fill",i.data.x,i.data.y,radius, 50);
	end
	for _,i in ipairs(self) do
		i.visit = false
	end
end

