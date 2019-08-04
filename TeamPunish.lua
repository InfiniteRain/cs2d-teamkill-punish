function initArray(m)
	local array = {}
	for i = 1, m do
		array[i] = 0
	end
	return array
end

alive=initArray(32)
kill=initArray(32)

addhook("kill","killcheck")
function killcheck(killer,victim)
	if player(killer,"team")==1 and player(victim,"team")==1 or player(killer,"team")==2 and player(victim,"team")==2 then
		menu(victim,"Choose punish,Kill him,Freeze him,Custom kill,Hit on 99 hp,Forgive him")
		kill[killer]=1
	end
end

addhook("spawn","alivecheck")
function alivecheck(id)
	alive[id]=1
end

addhook("kill","alivecheck2")
function alivecheck2(id)
	alive[id]=0
end

addhook("menu","menucheck")
function menucheck(id,menu,select)
	if (menu=="Choose punish") then
		if (select==1) then
			for i=1,32 do
				if player(i,"exists") and kill[i]==1 then
					parse("killplayer "..i)
					kill[i]=0
				end
			end
		end
		if (select==2) then
			for i=1,32 do
				if player(i,"exists") and kill[i]==1 then
					parse("speedmod "..i.." -100")
					kill[i]=0
				end
			end
		end
		if (select==3) then
			for i=1,32 do
				if player(i,"exists") and kill[i]==1 then
					parse('customkill '..i..' "I am idiot!" '..i)
					kill[i]=0
				end
			end
		end
		if (select==4) then
			for i=1,32 do
				if player(i,"exists") and kill[i]==1 then
					parse("sethealth "..i.." 1")
					kill[i]=0
				end
			end
		end
		if (select==5) then
			for i=1,32 do
				if player(i,"exists") and kill[i]==1 then
					kill[i]=0
				end
			end
		end
	end
end