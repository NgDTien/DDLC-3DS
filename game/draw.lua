function drawTopScreen()
	if drawbottom == 1 then
		love.graphics.pop()
		drawbottom = 0
	elseif global_os == 'Horizon' then
		love.graphics.setScreen("top")
	end
end

function drawBottomScreen()
	if global_os == 'Windows' then
		love.graphics.push()
		love.graphics.translate((400 - 320) / 2, 240)
		drawbottom = 1
	else
		love.graphics.setScreen("bottom")
	end
end

function dripText(text,charactersPerSecond,startTime)
	currentTime = love.timer.getTime()
	if (currentTime <= startTime) or startTime == 0 then return "" end
	if currentTime > startTime then myTextStartTime2 = love.timer.getTime() end
	return text:sub(1,math.min(math.floor((currentTime-startTime)*charactersPerSecond),text:len()))
end

function splashalpha(x)
	--team salvato splash
	if x == 1 then
		if timer <=150 then
			if alpha >= 255 then
				alpha = 255
			else
				alpha = alpha + 4.25
			end
		elseif timer <=200 then
			if alpha >= 1 then
				alpha = alpha - 4.25
			else
				alpha = 0
			end
		else alpha = 0 end
	--warning splash
	elseif x == 2 then
		if timer <=400 then
			if alpha >= 255 then
				alpha = 255
			else
				alpha = alpha + 4.25
			end
		elseif timer <=480 then
			if alpha >= 1 then
				alpha = alpha - 4.25
			else
				alpha = 0
			end
		else alpha = 0 end
	--fade in title screen
	elseif x == 3 then
		if alpha >= 255 then
			alpha = 255
		else
			if menu_enabled == false then menu_enable('title', 6) end
			alpha = alpha + 3
		end
	--fade out to poemgame
	elseif x == 4 then
		if alpha <= 0 then
			alpha = 255
			poemgame()
		else	
			alpha = alpha - 1.5
		end
	--fade out from poemgame to game
	elseif x == 5 then
		if alpha <= 0 then
			alpha = 255
			cl = cl + 2
			xaload = 0
			state = "game"
		else	
			alpha = alpha - 1.5
		end
	--fade from load to splash screens
	elseif x == 6 then
		if alpha <= 0 then
			resetchr(2)
			xaload = 0
			timer = 0
			state = "splash1"
			audioUpdate('1')
		else
			alpha = alpha - 5
		end
	end
end

function drawGame()
	scriptCheck()
	charCheck()	
	
	drawTopScreen()
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.draw(bgch, 0, 0)
	if xaload >= 1 and menu_enabled == false or menu_type == 'choice' then
		if cg1 ~= "" then love.graphics.draw(cgch, 0, 0) end
		drawSayori(s.a,s.b)
		drawYuri(y.a,y.b) 
		drawNatsuki(n.a,n.b)  
		drawMonika(m.a,m.b)
	end
	
	if menu_enabled ~= true and poem_enabled ~= true and settings.textloc == 'Top' then
		if ct ~= '' then love.graphics.draw(namebox, 52, 142) end
		love.graphics.draw(textbox, 40, 162)
		love.graphics.setColor(0,0,0)
		love.graphics.print(ct,60,142) --t name
		love.graphics.print(ca,48,166) --line 1
		love.graphics.print(cb,48,182) --line 2
		love.graphics.print(cc,48,198) --line 3
		love.graphics.print(cd,48,214) --line 4
		c_x = 0
	end
	
	if menu_enabled and menu_type ~= 'choice' then
		love.graphics.draw(background_Image, posX, posY)
	elseif poem_enabled then drawPoem()
	end
	
	drawBottomScreen()
	love.graphics.setColor(255,255,255,alpha)
	love.graphics.setFont(font)
	love.graphics.draw(background_Image, posX, posY)
	
	love.graphics.setColor(0,0,0)
	love.graphics.print(cl,0,0,0) --script number
	if autotimer > 0 then love.graphics.print('Auto/Skip - On', 0, 16) end
		
	if poem_enabled ~= true and settings.textloc == 'Bottom' then
		love.graphics.setColor(255,255,255,alpha)
		if ct ~= '' then love.graphics.draw(namebox, 12, 40) end
		love.graphics.draw(textbox, 0, 60)
		love.graphics.setColor(0,0,0)
		love.graphics.print(ct,20,40) --t name
		love.graphics.print(ca,8,64) --line 1
		love.graphics.print(cb,8,80) --line 2
		love.graphics.print(cc,8,96) --line 3
		love.graphics.print(cd,8,112) --line 4
		c_x = 220
	end
	
	if state ~= 'newgame' or poem_enabled == false then
		love.graphics.print("Y - Pause",40,c_x,0,1,1)
		love.graphics.print("B - Auto",135,c_x,0,1,1)
		love.graphics.print("X - Skip",225,c_x,0,1,1)
	end
	if menu_enabled then menu_draw() end
end

function drawPoem()
	love.graphics.draw(poembg, 40, 0)
	love.graphics.setColor(0,0,0)
	love.graphics.print(poemtext, 45, 15)
end

ct = "" --name text

function cgHide()
	cg1 = ''
end

function hideSayori()
	s.a = ''
	s.b = ''
end

function hideYuri()
	y.a = ''
	y.b = ''
end

function hideNatsuki()
	n.a = ''
	n.b = ''
end

function hideMonika()
	m.a = ''
	m.b = ''
end

function drawSayori(a,b)
	if a=="1" then
		love.graphics.draw(s1l, s.x)
		love.graphics.draw(s1r, s.x)
	elseif a=="2" then
		love.graphics.draw(s1l, s.x)
		love.graphics.draw(s2r, s.x)
	elseif a=="3" then
		love.graphics.draw(s2l, s.x)
		love.graphics.draw(s1r, s.x)
	elseif a=="4" then
		love.graphics.draw(s2l, s.x)
		love.graphics.draw(s2r, s.x)
	
	elseif a=="1b" then
		love.graphics.draw(s1bl, s.x)
		love.graphics.draw(s1br, s.x)
	elseif a=="2b" then
		love.graphics.draw(s1bl, s.x)
		love.graphics.draw(s2br, s.x)
	elseif a=="3b" then
		love.graphics.draw(s2bl, s.x)
		love.graphics.draw(s1br, s.x)
	elseif a=="4b" then
		love.graphics.draw(s2bl, s.x)
		love.graphics.draw(s2br, s.x)
	elseif a=="5a" then
		love.graphics.draw(s3a, s.x)
	elseif a=="5b" then
		love.graphics.draw(s3b, s.x)
	elseif a=="5c" then
		love.graphics.draw(s3c, s.x)
	elseif a=="5d" then
		love.graphics.draw(s3d, s.x)
	elseif a=="sayori" then
		love.graphics.draw(saf, s.x)
	end
	
	if b=="a" then
		love.graphics.draw(s_a, s.x)
	elseif b=="b" then
		love.graphics.draw(s_b, s.x)
	elseif b=="c" then
		love.graphics.draw(s_c, s.x)
	elseif b=="d" then
		love.graphics.draw(s_d, s.x)
	elseif b=="e" then
		love.graphics.draw(s_e, s.x)
	elseif b=="f" then
		love.graphics.draw(s_f, s.x)
	elseif b=="g" then
		love.graphics.draw(s_g, s.x)
	elseif b=="h" then
		love.graphics.draw(s_h, s.x)
	elseif b=="i" then
		love.graphics.draw(s_i, s.x)
	elseif b=="j" then
		love.graphics.draw(s_j, s.x)
	elseif b=="k" then
		love.graphics.draw(s_k, s.x)
	elseif b=="l" then
		love.graphics.draw(s_l, s.x)
	elseif b=="m" then
		love.graphics.draw(s_m, s.x)
	elseif b=="n" then
		love.graphics.draw(s_n, s.x)
	elseif b=="o" then
		love.graphics.draw(s_o, s.x)
	elseif b=="p" then
		love.graphics.draw(s_p, s.x)
	elseif b=="q" then
		love.graphics.draw(s_q, s.x)
	elseif b=="r" then
		love.graphics.draw(s_r, s.x)
	elseif b=="s" then
		love.graphics.draw(s_s, s.x)
	elseif b=="t" then
		love.graphics.draw(s_t, s.x)
	elseif b=="u" then
		love.graphics.draw(s_u, s.x)
	elseif b=="v" then
		love.graphics.draw(s_v, s.x)
	elseif b=="w" then
		love.graphics.draw(s_w, s.x)
	elseif b=="x" then
		love.graphics.draw(s_x, s.x)
	elseif b=="y" then
		love.graphics.draw(s_y, s.x)
	end
	
end

function drawYuri(a,b)
	if a=="1" then
		love.graphics.draw(y1l, y.x)
		love.graphics.draw(y1r, y.x)
	elseif a=="2" then
		love.graphics.draw(y1l, y.x)
		love.graphics.draw(y2r, y.x)
	elseif a=="3" then
		love.graphics.draw(y2l, y.x)
		love.graphics.draw(y2r, y.x)

	elseif a=="1b" then
		love.graphics.draw(y1bl, y.x)
		love.graphics.draw(y1br, y.x)
	elseif a=="2b" then
		love.graphics.draw(y1bl, y.x)
		love.graphics.draw(y2br, y.x)
	elseif a=="3b" then
		love.graphics.draw(y2bl, y.x)
		love.graphics.draw(y2br, y.x)
		
	elseif a=="4" then
		love.graphics.draw(y3_, y.x)
	elseif a=="4b" then
		love.graphics.draw(y3b, y.x)
	elseif a=="yuri" then
		love.graphics.draw(yaf, y.x)
	end

	if b=="a" then
		love.graphics.draw(y_a, y.x)
	elseif b=="a2" then
		love.graphics.draw(ya2, y.x)
	elseif b=="b" then
		love.graphics.draw(y_b, y.x)
	elseif b=="b2" then
		love.graphics.draw(yb2, y.x)
	elseif b=="c" then
		love.graphics.draw(y_c, y.x)
	elseif b=="c2" then
		love.graphics.draw(yc2, y.x)
	elseif b=="d" then
		love.graphics.draw(y_d, y.x)
	elseif b=="d2" then
		love.graphics.draw(yd2, y.x)
	elseif b=="e" then
		love.graphics.draw(y_e, y.x)
	elseif b=="e2" then
		love.graphics.draw(ye2, y.x)
	elseif b=="f" then
		love.graphics.draw(y_f, y.x)
	elseif b=="g" then
		love.graphics.draw(y_g, y.x)
	elseif b=="h" then
		love.graphics.draw(y_h, y.x)
	elseif b=="i" then
		love.graphics.draw(y_i, y.x)
	elseif b=="j" then
		love.graphics.draw(y_j, y.x)
	elseif b=="k" then
		love.graphics.draw(y_k, y.x)
	elseif b=="l" then
		love.graphics.draw(y_l, y.x)
	elseif b=="m" then
		love.graphics.draw(y_m, y.x)
	elseif b=="n" then
		love.graphics.draw(y_n, y.x)
	elseif b=="o" then
		love.graphics.draw(y_o, y.x)
	elseif b=="p" then
		love.graphics.draw(y_p, y.x)
	elseif b=="q" then
		love.graphics.draw(y_q, y.x)
	elseif b=="r" then
		love.graphics.draw(y_r, y.x)
	elseif b=="s" then
		love.graphics.draw(y_s, y.x)
	elseif b=="t" then
		love.graphics.draw(y_t, y.x)
	elseif b=="u" then
		love.graphics.draw(y_u, y.x)
	elseif b=="v" then
		love.graphics.draw(y_v, y.x)
	elseif b=="w" then
		love.graphics.draw(y_w, y.x)
	elseif b=="y6" then
		love.graphics.draw(yy6, y.x)
	end
end

function drawNatsuki(a,b)
	if b=="a" then
		love.graphics.draw(n_a, nxh, nyh)
	elseif b=="b" then
		love.graphics.draw(n_b, nxh, nyh)
	elseif b=="c" then
		love.graphics.draw(n_c, nxh, nyh)
	elseif b=="d" then
		love.graphics.draw(n_d, nxh, nyh)
	elseif b=="e" then
		love.graphics.draw(n_e, nxh, nyh)
	elseif b=="f" then
		love.graphics.draw(n_f, nxh, nyh)
	elseif b=="g" then
		love.graphics.draw(n_g, nxh, nyh)
	elseif b=="h" then
		love.graphics.draw(n_h, nxh, nyh)
	elseif b=="i" then
		love.graphics.draw(n_i, nxh, nyh)
	elseif b=="j" then
		love.graphics.draw(n_j, nxh, nyh)
	elseif b=="k" then
		love.graphics.draw(n_k, nxh, nyh)
	elseif b=="l" then
		love.graphics.draw(n_l, nxh, nyh)
	elseif b=="m" then
		love.graphics.draw(n_m, nxh, nyh)
	elseif b=="n" then
		love.graphics.draw(n_n, nxh, nyh)
	elseif b=="o" then
		love.graphics.draw(n_o, nxh, nyh)
	elseif b=="p" then
		love.graphics.draw(n_p, nxh, nyh)
	elseif b=="q" then
		love.graphics.draw(n_q, nxh, nyh)
	elseif b=="r" then
		love.graphics.draw(n_r, nxh, nyh)
	elseif b=="s" then
		love.graphics.draw(n_s, nxh, nyh)
	elseif b=="t" then
		love.graphics.draw(n_t, nxh, nyh)
	elseif b=="u" then
		love.graphics.draw(n_u, nxh, nyh)
	elseif b=="v" then
		love.graphics.draw(n_v, nxh, nyh)
	elseif b=="w" then
		love.graphics.draw(n_w, nxh, nyh)
	elseif b=="x" then
		love.graphics.draw(n_x, nxh, nyh)
	elseif b=="y" then
		love.graphics.draw(n_y, nxh, nyh)
	elseif b=="z" then
		love.graphics.draw(n_z, nxh, nyh)
	
	elseif b=="1t" then
		love.graphics.draw(n1t, nxh, nyh)
	elseif b=="2a" then
		love.graphics.draw(n2bta, nxh, nyh)
	elseif b=="2b" then
		love.graphics.draw(n2btb, nxh, nyh)
	elseif b=="2c" then
		love.graphics.draw(n2btc, nxh, nyh)
	elseif b=="2d" then
		love.graphics.draw(n2btd, nxh, nyh)
	elseif b=="2e" then
		love.graphics.draw(n2bte, nxh, nyh)
	elseif b=="2f" then
		love.graphics.draw(n2btf, nxh, nyh)
	elseif b=="2g" then
		love.graphics.draw(n2btg, nxh, nyh)
	elseif b=="2h" then
		love.graphics.draw(n2bth, nxh, nyh)
	elseif b=="2i" then
		love.graphics.draw(n2bti, nxh, nyh)	
	end
	
	if a=="1" then
		love.graphics.draw(n1l, n.x)
		love.graphics.draw(n1r, n.x)
	elseif a=="2" then
		love.graphics.draw(n1l, n.x)
		love.graphics.draw(n2r, n.x)
	elseif a=="3" then
		love.graphics.draw(n2l, n.x)
		love.graphics.draw(n1r, n.x)
	elseif a=="4" then
		love.graphics.draw(n2l, n.x)
		love.graphics.draw(n2r, n.x)
		
	elseif a=="1b" then
		love.graphics.draw(n1bl, n.x)
		love.graphics.draw(n1br, n.x)
	elseif a=="2b" then
		love.graphics.draw(n1bl, n.x)
		love.graphics.draw(n2br, n.x)
	elseif a=="3b" then
		love.graphics.draw(n2bl, n.x)
		love.graphics.draw(n1br, n.x)
	elseif a=="4b" then
		love.graphics.draw(n2bl, n.x)
		love.graphics.draw(n2br, n.x)
	
	elseif a=="5" then
		love.graphics.draw(n3_, n.x)
	elseif a=="5b" then
		love.graphics.draw(n3b, n.x)
	elseif a=="natsuki" then
		love.graphics.draw(naf, n.x)
	elseif a=="natsuki2" then
		love.graphics.draw(nbf, n.x)
	end
	
	if a=="5" or a=="5b" then --set natsuki's head x and y
		nxh = n.x+4
		nyh = n.y+6
	else
		nxh = n.x
		nyh = n.y
	end
end

function drawMonika(a,b)
	if a=="1" then
		love.graphics.draw(m1l, m.x)
		love.graphics.draw(m1r, m.x)
	elseif a=="2" then
		love.graphics.draw(m1l, m.x)
		love.graphics.draw(m2r, m.x)
	elseif a=="3" then
		love.graphics.draw(m2l, m.x)
		love.graphics.draw(m1r, m.x)
	elseif a=="4" then
		love.graphics.draw(m2l, m.x)
		love.graphics.draw(m2r, m.x)
	elseif a=="5a" then
		love.graphics.draw(m3a, m.x)
	elseif a=="5b" then
		love.graphics.draw(m3b, m.x)
	end
	
	if b=="a" then
		love.graphics.draw(m_a, m.x)
	elseif b=="b" then
		love.graphics.draw(m_b, m.x)
	elseif b=="c" then
		love.graphics.draw(m_c, m.x)
	elseif b=="d" then
		love.graphics.draw(m_d, m.x)
	elseif b=="e" then
		love.graphics.draw(m_e, m.x)
	elseif b=="f" then
		love.graphics.draw(m_f, m.x)
	elseif b=="g" then
		love.graphics.draw(m_g, m.x)
	elseif b=="h" then
		love.graphics.draw(m_h, m.x)
	elseif b=="i" then
		love.graphics.draw(m_i, m.x)
	elseif b=="j" then
		love.graphics.draw(m_j, m.x)
	elseif b=="k" then
		love.graphics.draw(m_k, m.x)
	elseif b=="l" then
		love.graphics.draw(m_l, m.x)
	elseif b=="m" then
		love.graphics.draw(m_m, m.x)
	elseif b=="n" then
		love.graphics.draw(m_n, m.x)
	elseif b=="o" then
		love.graphics.draw(m_o, m.x)
	elseif b=="p" then
		love.graphics.draw(m_p, m.x)
	elseif b=="q" then
		love.graphics.draw(m_q, m.x)
	elseif b=="r" then
		love.graphics.draw(m_r, m.x)
	end
end

