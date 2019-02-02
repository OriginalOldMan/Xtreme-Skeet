require 'Utils'

function Physics()
	local physics = {}
	physics.update = physicsUpdate
	physics.draw = physicsDraw
	return physics
end

function physicsUpdate(physics, dt)
	for key, bullet in pairs(objects.bullets) do
		for key2, pigeon in pairs(objects.pigeons) do
			--Bullet and pigeon are colliding
			if  dist(bullet.x, bullet.y, pigeon.x, pigeon.y) < (bullet.radius + pigeon.radius) then
				print("Collision")
				if (bullet.owner == 1) then
					objects.players[1].score = objects.players[1].score + 1
					print("player 1 scores")
				else
					objects.players[2].score = objects.players[2].score + 1
					print("player 2 scores")
				end
				bulletToPigeon = {}
				bulletToPigeon.x = 10*(pigeon.x - bullet.x)
				bulletToPigeon.y = 10*(pigeon.y - bullet.y)
				pigeon.velocity.x = pigeon.velocity.x + bulletToPigeon.x
				pigeon.velocity.y = pigeon.velocity.y + bulletToPigeon.y
				for i=1,pigeon.numFragments do
					local fragment = Fragment(pigeon.x, pigeon.y, {})
					theta = math.random()
					randMag = math.random()/2 + 1
					fragment.velocity.x = (pigeon.velocity.x * math.cos(theta) - pigeon.velocity.y * math.sin(theta)) * randMag
					fragment.velocity.y = (pigeon.velocity.x * math.sin(theta) + pigeon.velocity.y * math.cos(theta)) * randMag
					table.insert(objects.fragments, fragment)
				end
				bullet.velocity.x = bullet.velocity.x - bulletToPigeon.x
				bullet.velocity.y = bullet.velocity.y - bulletToPigeon.y
				table.remove(objects.pigeons, key2)
			end
		end
	end
end

function physicsDraw(physics)
	
end