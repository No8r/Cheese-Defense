local TFM = tfm.exec
local GET = tfm.get
local addTextArea = ui.addTextArea
local zombie = {}
local player = {}
local objects = {}
local imgs = {}
local data = {}
local coins = {}
local jumpPoints = {}
local respawnPoints = {left = {},right={}}
local game = {
    name = "Cheese Defense",
    names = {},
    keyboard_keys = {0,1,2,3,32,81},
    commands = {"map", "shop"},
    map = {
        correntMap = 1 ,
        l = 1600 ,
    },
    wave = 0 ,
    players = 0 ,
    time = 5 * 60 , 
    over = {"174f9a0c9d3.png",false},
    team = {
        developer = "Noooooooorr#0000",
    },
    cheese = {
        hp = 100 , 
        x = 800 ,
        y = 200 ,
        images = {"17513648f5a.png","175136477ea.png","17513646078.png","17513644905.png","17513643194.png","17513641a22.png","175136402b0.png"}
    },
    zombies = {
        number = 0 ,
        skeleton = {
            hp = 50 , 
            damage = 20 ,
            spawnY = 237 ,
            left = "174e07ab618.png",
            leftfight = "174fa817cd8.png",
            leftgettingdamaged = "",
            right = "174e07bdc9c.png",
            rightfight = "174fa82123b.png",
        },
        --[[
        big_skeleton = {
            hp = 70 , 
            damage = 25 ,
            spawnY = 237 ,
            left = "174f04d38bc.png",
            right = "174f04e9e22.png"
        },]]
    }
}


local languages = {
    ar = {
        welcomeMessage = "<fc>مرحبا بك في نمط حماية الجبن\n كل ما عليك فعله هو حماية الجبن من الوحوش \n لبثق كرة قم بالضغط على الزر الأسفل و للطيران قم بضغط زر المسافة</fc>", 
        cannon_blue = "الكرة الزرقاء",
        cannon_deadly = "الكرة المميتة",
        cannon_fireball = "كرة النار",
        dontHaveEnoughCoins = "<R>ليس لديك عملات معدنية كافية لشراء هذا المدفع</R>",
        reloadFaster = "<v>x%s</v> يمكن إعادة قذفها بشكل أسرع بمقدار",
        toOpentheShop = "لفتح  متجر المدافع <vr>!shop</vr> اكتب",
    },
    en = {
        welcomeMessage = "<fc><b>Welcome to Cheese Defense!</b>\nAll you have to do is protect the cheese from monsters \nduck to shoot a cannon ,and to fly press spacebar</fc>", 
        cannon_blue = "Blue Cannon",
        cannon_deadly = "Deadly Cannon",
        cannon_fireball = "FireBall",
        dontHaveEnoughCoins = "<R>You do not have enough coins to buy this cannon.</R>",
        reloadFaster = "Re-Shot faster by <vr>x%s</vr>",
        toOpentheShop = "TYPE <v>!shop</v> TO OPEN THE CANNONS SHOP!",
    },
}

local maps = {
    [1] = {"@661", "Noooooooorr#0000", '<C><P L="1600"/><Z><S><S N="" i="5,5,174df4d1998.png"/><S i="5,5,174df4ad8ef.png"/><S X="801" Y="371" T="9" L="1601" H="64" P="0,0,0,0,0,0,0,0" c="4" m=""/><S X="128" Y="193" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="1478" Y="196" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="747" Y="404" T="14" L="1228" H="10" P="0,0,0,0,0,0,0,0" c="2"/><S X="545" Y="331" T="6" L="52" H="148" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1060" Y="332" T="6" L="52" H="148" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="802" Y="331" T="6" L="351" H="148" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1262" Y="287" T="6" L="200" H="59" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="346" Y="287" T="6" L="200" H="59" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="92" Y="330" T="6" L="200" H="149" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1508" Y="332" T="6" L="200" H="149" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="544" Y="165" T="6" L="54" H="54" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1061" Y="158" T="6" L="54" H="54" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="805" Y="-15" T="14" L="1086" H="10" P="0,0,0.3,0.2,0,0,0,0"/><S X="793" Y="267" T="14" L="1246" H="10" P="0,0,0.3,0.2,0,0,0,0" c="2"/></S><D><DS X="800" Y="240"/></D><O><O X="559" Y="238" C="22" P="0,0"/><O X="430" Y="238" C="22" P="10,0"/><O X="182" Y="233" C="22" P="0,0"/><O X="1048" Y="239" C="14" P="0,0"/><O X="1175" Y="235" C="14" P="0,0"/><O X="1421" Y="237" C="14" P="0,0"/><O X="113" Y="237" C="12" P="0,0"/><O X="42" Y="235" C="12" P="0,0"/><O X="1467" Y="239" C="13" P="0,0"/><O X="1546" Y="238" C="13" P="0,0"/><O X="1272" Y="238" C="13" P="0,0"/><O X="337" Y="235" C="12" P="0,0"/></O><L/></Z></C>'},
    [2] = {"@663", "Noooooooorr#0000", '<C><P L="1600"/><Z><S><S N="" i="5,5,174f982383b.png"/><S i="5,5,174f981f939.png"/><S X="128" Y="193" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="1478" Y="196" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="518" Y="128" T="6" L="54" H="54" P="0,0,0.3,0.2,0,0,0,0" m="" c="3"/><S X="1066" Y="124" T="6" L="54" H="54" P="0,0,0.3,0.2,0,0,0,0" m="" c="3"/><S X="798" Y="114" T="6" L="170" H="57" P="0,0,0.3,0.2,0,0,0,0" m="" c="3"/><S X="518" Y="319" T="6" L="60" H="167" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1064" Y="319" T="6" L="60" H="167" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1236" Y="354" T="6" L="60" H="167" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="380" Y="341" T="6" L="60" H="167" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="123" Y="339" T="6" L="250" H="164" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1488" Y="344" T="6" L="250" H="164" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="802" Y="339" T="6" L="301" H="161" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="800" Y="373" T="9" L="1613" H="71" P="0,0,0,0,0,0,0,0" c="4" m=""/><S X="678" Y="-16" T="14" L="1371" H="23" P="0,0,0.3,0.2,0,0,0,0"/><S X="677" Y="411" T="14" L="1371" H="23" P="0,0,0.3,0.2,0,0,0,0" c="2"/><S X="810" Y="281" T="14" L="1149" H="10" P="0,0,0.3,0.2,0,0,0,0" c="2"/><S X="453" Y="255" T="14" L="88" H="10" P="0,0,0.3,0.2,-20,0,0,0" c="2"/><S X="995" Y="260" T="14" L="88" H="10" P="0,0,0.3,0.2,-20,0,0,0" c="2"/><S X="596" Y="258" T="14" L="108" H="10" P="0,0,0.3,0.2,15,0,0,0" c="2"/><S X="1146" Y="266" T="14" L="108" H="10" P="0,0,0.3,0.2,20,0,0,0" c="2"/></S><D><DS X="800" Y="240"/></D><O><O X="236" Y="237" C="22" P="20,0"/><O X="407" Y="240" C="22" P="25,0"/><O X="541" Y="215" C="22" P="0,0"/><O X="1041" Y="216" C="14" P="0,0"/><O X="1209" Y="250" C="14" P="25,0"/><O X="1371" Y="247" C="14" P="25,0"/><O X="55" Y="238" C="12" P="0,0"/><O X="172" Y="238" C="12" P="0,0"/><O X="1453" Y="241" C="13" P="0,0"/><O X="1552" Y="241" C="13" P="0,0"/><O X="1248" Y="253" C="13" P="0,0"/><O X="360" Y="239" C="12" P="0,0"/></O><L/></Z></C>'},
    [3] = {"@664", "Noooooooorr#0000", '<C><P L="2000"/><Z><S><S N="" i="5,5,17508f2461e.png"/><S i="5,5,17508f1f919.png"/><S X="138" Y="184" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="1868" Y="187" T="14" L="271" H="418" P="0,0,0,0,0,0,0,0" c="3"/><S X="117" Y="329" T="6" L="250" H="164" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="557" Y="331" T="6" L="174" H="162" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1441" Y="331" T="6" L="174" H="162" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="992" Y="333" T="6" L="290" H="165" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1902" Y="328" T="6" L="250" H="164" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="891" Y="-16" T="14" L="1797" H="23" P="0,0,0.3,0.2,0,0,0,0"/><S X="1001" Y="370" T="6" L="2000" H="164" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1238" Y="325" T="6" L="58" H="153" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1646" Y="326" T="6" L="58" H="153" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="746" Y="323" T="6" L="58" H="153" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="355" Y="323" T="6" L="58" H="153" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="354" Y="124" T="6" L="150" H="51" P="0,0,0.3,0.2,0,0,0,0" m=""/><S X="1643" Y="124" T="6" L="150" H="51" P="0,0,0.3,0.2,0,0,0,0" m=""/></S><D><DS X="1000" Y="235"/></D><O><O X="236" Y="237" C="22" P="10,0"/><O X="380" Y="236" C="22" P="10,0"/><O X="634" Y="234" C="22" P="10,0"/><O X="769" Y="234" C="22" P="10,0"/><O X="1784" Y="228" C="14" P="10,0"/><O X="1623" Y="234" C="14" P="10,0"/><O X="1364" Y="235" C="14" P="10,0"/><O X="1209" Y="235" C="14" P="10,0"/><O X="38" Y="228" C="12" P="0,0"/><O X="1946" Y="226" C="13" P="0,0"/><O X="825" Y="287" C="22" P="50,0"/><O X="693" Y="290" C="22" P="50,0"/><O X="439" Y="290" C="22" P="50,0"/><O X="298" Y="288" C="22" P="50,0"/><O X="1290" Y="285" C="14" P="50,0"/><O X="1152" Y="283" C="14" P="50,0"/><O X="1549" Y="283" C="14" P="40,0"/><O X="1704" Y="283" C="14" P="50,0"/></O><L/></Z></C>'}
}

local cannons = {
    [1] = {"178290985e7.png", -15, -20, 0, "blue", reload = 1},
    [2] = {"17829094ad0.png", -15, -20, 15, "deadly", reload = 2},
    [3] = {"178233883cf.png", -15, -20, 30, "fireball", reload = 3}
}

TFM.disableAutoScore(true)
TFM.disableAutoShaman(true)
TFM.disablePhysicalConsumables(true)
TFM.disablePhysicalConsumables(true)
TFM.disableAutoNewGame(true)

zombie.id = {}

function translate(id, name)
    if data[name] then
        if languages[data[name].langue] then
            if languages[data[name].langue][id] then
                return languages[data[name].langue][id]
            else
                return languages["en"][id]
            end
        elseif languages["en"] then
            return languages["en"][id]
        else
            return "error"
        end
    end
end

function string.name(name)
	if game.names[name] then
		return game.names[name]
	else
		local hashtag,hashtagColor = "(#%d%d%d%d)","<font size='10'><g>%1</g></font>"
		game.names[name] = string.gsub(name, hashtag, hashtagColor)
		return game.names[name]
	end
end

function isNear(name, x1, y1, hSpace, vSpace)
    if name == "cheese" then
    local cheese = game.cheese
        if cheese.x > x1-hSpace and cheese.x < x1 + hSpace  and cheese.y > y1-vSpace and cheese.y < y1 + vSpace then
            return true
        end
    else
        local p = GET.room.playerList[name]
        if p.x > x1-hSpace and p.x < x1+hSpace and p.y > y1-vSpace and p.y < y1+vSpace then
            return true
        end
    end
end

function near(x, y, x1, y1, hSpace, vSpace)
    if x > x1 - hSpace and x < x1 + hSpace and y > y1 - vSpace and y < y1 + vSpace then
        return true
    end
end

function zombie.isNear(zombie)
    for name in pairs(GET.room.playerList) do
        if isNear(name,zombie.x,zombie.y,50,50) then
            player[name].hp = player[name].hp - zombie.damage
            return true
        else
            return false
        end
    end
end


function zombie.movements(zombie)
    if not game.over[2] then
        connonDamage(zombie)
        local id = zombie.id
        local type = zombie.type
        local object = GET.room.objectList[id]
        local jump 
        if jumpPoints then
            for _,point in pairs(jumpPoints) do 
                if point then 
                    if near(object.x, object.y, point.x, point.y,30,20) then
                        TFM.moveObject(id, 0, 0, true, point.direction, -40-tonumber(point.p) , false,0,true)
                        jump = true
                    end
                end
            end
        end
        if zombie.walking and not jump then 
            if zombie.side == "left" then
                TFM.moveObject(id, 0, 0, true, 20, -20, false,0,true)
                if object.x > game.map.l/2 then 
                    zombie.side = "right"
                end
            else
                TFM.moveObject(id, 0, 0, true, -20, -20, false,0,true)
                if object.x < game.map.l/2 then 
                    zombie.side = "left"
                end
            end
            zombie.image = TFM.addImage(game.zombies[type][zombie.side],"#"..id,-20,-30)
        end
        if GET.room.objectList[id] then
            local monster =  GET.room.objectList[id]
            if isNear("cheese",monster.x,monster.y,50,50) then
                zombie.image = TFM.addImage(game.zombies[type][zombie.side.."fight"],"#"..id,-30,-30)
                game.cheese.hp = game.cheese.hp - zombie.damage/4
                updateBars("cheese")
                zombie.walking = false
            else
                zombie.walking = true
            end
            if zombie.hp <= 0 or monster.x > game.map.l or monster.x < 0 or monster.y > 300 then
                zombie_kill(zombie)
            end
            for name in pairs(GET.room.playerList) do
                if player[name].alive then
                    if isNear(name,monster.x,monster.y,70,50) then
                        if not player[name].shield then
                            zombie.image = TFM.addImage(game.zombies[type][zombie.side.."fight"],"#"..id,-30,-30)
                            player[name].hp = player[name].hp - zombie.damage
                            updateBars("life",name)
                            zombie.walking = false
                        end
                    else
                        zombie.walking = true
                    end
                end
            end
        end
    end
end

function zombie.spawn(sort,place)
    local x , y , id , monster
    game.zombies.number = game.zombies.number + 1
    if place == 1 then
        place = "left"
        if respawnPoints and respawnPoints.left then 
            x = respawnPoints.left[math.random(1,#respawnPoints.left)].x
        else
            x = math.random(20,90)
        end
    else 
        place = "right"
        if respawnPoints and respawnPoints.right then 
            x = respawnPoints.right[math.random(1,#respawnPoints.right)].x 
        else
            x = math.random(1540,1580)
        end
    end
    y = game.zombies[sort].spawnY
    id = #zombie.id+1
    monster = game.zombies[sort]
    updateMapName()
    zombie.id[id] = {id = TFM.addShamanObject(10, x, y,0,0,false), type = sort, image = nil, alive = true, hp = monster.hp, damage = monster.damage , side = place , timer = nil, walking = true}
    zombie.id[id].image = TFM.addImage(monster[place],"#"..zombie.id[id].id,-30,-30)
    zombie.id[id].timer = system.newTimer(function()
        zombie.movements(zombie.id[id])
    end,1000,true)
end

function zombie_kill(zombie)
    local id = zombie.id
    local monster =  GET.room.objectList[id]
    system.removeTimer(zombie.timer)
    coins[#coins + 1] = {
        id = zombie.id,
        bonus = TFM.addBonus(0, monster.x + 4, monster.y + 5, zombie.id, 0, false),
        img = TFM.addImage("17828a616a4.png", "!9", monster.x - 10, monster.y - 10)
    }
    TFM.removeObject(id)
    zombie = nil
    game.zombies.number = game.zombies.number - 1
    updateMapName()
    if game.zombies.number == 0 then 
        game.wave = game.wave + 1
        waves( game.wave )
    end
end

function cannonsShop(name, page)
    local x,y = 400, 200
    local cannon = cannons[page]
    if imgs[name][1] then TFM.removeImage(imgs[name][1]) imgs[name][1] = nil end
    if imgs[name][2] then TFM.removeImage(imgs[name][2]) imgs[name][1] = nil end
    imgs[name][1] = TFM.addImage("17828b4085e.png", ":1", x - (260/2), y - (245/2))
    imgs[name][2] = TFM.addImage(cannon[1], ":2", x + cannon[2] + 25 , y + cannon[3] - 45)
    ui.removeTextArea(10002, name)
    addTextArea(10000, "<font size='20'><p align='center'><a href='event:closeShop'> \n \n \n \n ", name, x + 90, y - 120, 30, 30, 0x01, 0x0909, 0, true)
    addTextArea(10001, "<font size='13' color = '#2f2e38'><p align='center'><a href='event:buyCannon_"..page.."'>Buy", name, x - 25,  y + 60, 100, 25, 0xFFBA25, 0xFFBA25,0, true)      
    addTextArea(10003, "<font size='15' color = '#2f2e38'><p align='center'><b>" .. data[name].coins, name, x - 100 , y - 75, 40, 25, 0xFFBA25, 0xFFBA25,0, true)
    addTextArea(10004, "<font size='16' color = '#2f2e38'><p align='center'><B>".. translate("cannon_" .. cannon[5], name), name, x - 50,  y , 145, 25, 0x14, 0x13, 0, true)      
    addTextArea(10005, "<font size='20'><p align='center'><a href='event:previousCannon'>\n\n\n", name, x - 40,  y - 50, 30, 25, 0x14, 0x13, 0, true)    
    addTextArea(10006, "<font size='20'><p align='center'><a href='event:nextCannon'>\n\n\n", name, x + 55,  y - 50, 30, 25, 0x14, 0x13, 0, true)  
    if page ~= 1 then 
        addTextArea(10007, "<font size='9' color = '#FFC27E'><p align='center'><B>".. string.format(translate("reloadFaster", name), cannon.reload), name, x - 50,  y+20 , 145, 25, 0x14, 0x13, 0, true)          
    end
    if data[name].cannons[page] then
        if page ~= data[name].currentCannon then 
            addTextArea(10001, "<font size='13' color = '#2f2e38'><p align='center'><a href='event:selectCannon_"..page.."'>Select", name, x - 25,  y + 60, 100, 25, 0xFFBA25, 0xFFBA25,0, true)
        elseif page == data[name].currentCannon then
            addTextArea(10001, "<font size='13' color = '#2f2e38'><p align='center'>Selected", name, x - 25,  y + 60, 100, 25, 0xFFBA25, 0xFFBA25,0, true)
        end
    else
        addTextArea(10002, "<font size='18' color = '#f4bd52'><p align='center'>$" .. cannon[4], name, x - 5 , y + 30, 55, 30, 0xFFBA25, 0xFFBA25,0, true)
    end
end

function removeCannonShop(name)
    if imgs[name][1] then TFM.removeImage(imgs[name][1]) imgs[name][1] = nil end
    if imgs[name][2] then TFM.removeImage(imgs[name][2]) imgs[name][2] = nil end
    for i= 10000, 10007 do 
        ui.removeTextArea(i,name)
    end
end

function coinCollect(name, id)
    for i=1 ,#coins do 
        local coin = coins[i]
        if coin then 
            if coin.id == id then 
                data[name].coins = data[name].coins + 1 
                TFM.removeImage(coin.img)
                table.remove(coins, i)
            end
        end
    end
end

function eventChatCommand(name,mes)
	local cmd, u = {}, 1
    for i in string.gmatch(mes, "%S+") do
        cmd[u] = i
        u = u + 1
    end
    if cmd[1] == "shop" then 
        cannonsShop(name, 1)
    elseif name == "Noooooooorr#0000" then
        if cmd[1] == "map" then
            if cmd[2] then
                TFM.chatMessage("<r><b>"..cmd[2].."</r></b>")
                setMap(cmd[2])
            else
                setMap()
            end
        end
    end
end

function eventPlayerBonusGrabbed(name ,id)
    if id then 
        coinCollect(name, id)
    end
end

function eventPlayerDied(name)
    player[name].alive = false
    system.newTimer(function()
        TFM.respawnPlayer(name)
    end,10000,false)
end

function eventPlayerRespawn(name)
    player[name] = {facingLeft = false,flying = nil ,connon = nil , hp = 100, fly = 100, alive = true, dialog = nil, wing = nil, shield = true,shieldImg = TFM.addImage("177503cb1e6.png", "$"..name,-35, -45), menuPage = 1}
    updateBars("life",name)
    system.newTimer(function() player[name].shield = false TFM.removeImage(player[name].shieldImg)  end, 7000, false)
end

function eventNewGame()
    local cheese = game.cheese
    game.wave = 1 
    waves( game.wave + 1 )
    removeTimers()
    jumpPoints = {}
    respawnPoints = {left = {},right={}}
    setPoints()
    zombie.id = {}
    game.zombies.number = 0
    cheese.x = game.map.l/2 
    cheese.hp = 100
    game.over[2] = false
    imgs[1] = TFM.addImage(cheese.images[7],"_1000", cheese.x-80, cheese.y-35)
    imgs[2] = TFM.addImage("174e57ff929.png", ":0", 5, 20)
    imgs[3] = TFM.addImage("174e571d9be.png", "&0",5, 20)
    addTextArea(1,"",nil, 40, 42, 150, 1, 0xFFBA25, 0xFFBA25,1, true)
    addTextArea(2,"",nil, 40, 85, 90, 1, 0xFE2538, 0xFE2538,1, true)
    addTextArea(3,"",nil, 40, 125, 70, 1, 0x50C0B7, 0x50C0B7,1, true)
    for name in pairs(GET.room.playerList) do
        game.players = game.players + 1 
        player[name] = {facingLeft = false,flying = nil ,connon = nil , hp = 100 , fly = 100 , alive = true, shield = false, shieldImg = nil, menuPage = 1}
    end
    updateBars()
end

function eventNewPlayer(name)
    player[name] = {facingLeft = false, flying = nil , connon = nil , hp = 100 , fly = 100 , alive = false, dialog = nil, wing = nil, shield = false, shieldImg = nil, menuPage = 1}
    imgs[name] = {}
    if not data[name] then 
        data[name] = {coins = 5, cannons = {[1]=true , [2] = false, [3] = false}, currentCannon = 1, langue = GET.room.playerList[name].language}
    end
    TFM.chatMessage(translate("welcomeMessage", name).."\n"..translate("toOpentheShop", name), name)
    for _,k in pairs(game.keyboard_keys) do
        TFM.bindKeyboard(name, k, true,true)
        TFM.bindKeyboard(name, k, false,true)
	end
end

function eventLoop()
    for name in next, tfm.get.room.playerList do
        if player[name].flying then 
            flying(name)
        end
        if player[name].fly < 100 then
            player[name].fly =  player[name].fly + 5
            if player[name].fly > 100 then
                player[name].fly = 100
            end
            updateBars("fly",name)
        end
    end
    damaging()
end

function eventKeyboard(name,k,down)
    if player[name].alive then  
        if k == 0 then
            player[name].facingLeft = true
            updatewings(name,true)
        elseif k == 2 then
            player[name].facingLeft = false
            updatewings(name,true)
        elseif down and k == 32  then
            player[name].flying = true
            updatewings(name)
        elseif not down and k == 32 then
            player[name].flying = false
            TFM.removeImage(player[name].wing)
        elseif k == 81 then
            if not player[name].dialog then
                player[name].dialog = TFM.addImage( "174f3d121fb.png", "$"..name, 20, -40)
                system.newTimer(function() TFM.removeImage(player[name].dialog)  player[name].dialog = nil end,5000,false)
            end
        elseif k == 3 then 
            local cannon = cannons[data[name].currentCannon]
            if not player[name].connon or player[name].connon + 3000/cannon.reload < os.time() then
                local p = GET.room.playerList[name]
                local id = #objects + 1
                player[name].connon = os.time()
                if player[name].facingLeft then 
                    objects[id] = TFM.addShamanObject(17, p.x-20, p.y, -90, 100, 0, false)
                    TFM.addImage(cannon[1], "#" .. objects[id] , cannon[2], cannon[3]) 
                    system.newTimer(function() TFM.removeObject(objects[id]) end, 3000/cannon.reload, false)
                else
                    objects[id] = TFM.addShamanObject(17, p.x+20, p.y, 90, -100, 0, false)
                    TFM.addImage(cannon[1], "#".. objects[id] , cannon[2], cannon[3]) 
                    system.newTimer(function() TFM.removeObject(objects[id]) end, 3000/cannon.reload, false)
                end
            end
        end       
    end 
end

function connonDamage(monster)
    for _,object in pairs(objects) do
        if object then
            local o = GET.room.objectList[object]
            local zombie = GET.room.objectList[monster.id]
            if zombie then
                if o then
                    if near(o.x, o.y, zombie.x, zombie.y,70,70) then
                        TFM.removeObject(object)
                        monster.hp = monster.hp - 26
                        TFM.displayParticle(10,zombie.x,zombie.y)
                        object = nil
                    end
                end
            end
        end
    end
end

function eventTextAreaCallback(id, name, cb)
    if cb == "closeShop" then
        removeCannonShop(name)
    elseif cb == "previousCannon" then 
        if player[name].menuPage == 1 then player[name].menuPage = #cannons else player[name].menuPage = player[name].menuPage - 1 end
        cannonsShop(name, player[name].menuPage)
    elseif cb == "nextCannon" then 
        if player[name].menuPage == #cannons then player[name].menuPage = 1 else player[name].menuPage = player[name].menuPage + 1 end
        cannonsShop(name, player[name].menuPage) 
    end
    for i = 1, #cannons do
        if cb == "buyCannon_"..tostring(i) then 
            if not data[name].cannons[i] then 
                if data[name].coins >= cannons[i][4] then
                    data[name].coins = data[name].coins - cannons[i][4]
                    print(cannons[i][5])
                    data[name].cannons[i] = true
                    cannonsShop(name ,player[name].menuPage)
                else
                    TFM.chatMessage( translate("dontHaveEnoughCoins", name), name)
                end
            end
        elseif cb == "selectCannon_" ..tostring(i) then
            data[name].currentCannon = i
            cannonsShop(name ,player[name].menuPage)
        end
    end
end

function removeTimers()
    for _,zombieTimer in pairs(zombie.id) do
        system.removeTimer(zombieTimer.timer)
    end
    for _,object in pairs(GET.room.objectList) do
        TFM.removeObject(object)
        GET.room.objectList[object] = nil 
    end
end

function updatewings(name,facing)
    if player[name].flying then
        if facing then
            if player[name].wing then
                TFM.removeImage(player[name].wing)
                if player[name].facingLeft then
                    player[name].wing = TFM.addImage( "174f522620d.png", "$"..name, 0, -20)
                else
                    player[name].wing = TFM.addImage( "174f525af4a.png", "$"..name, -35, -20)
                end
            end
        else
            if player[name].facingLeft then
                player[name].wing = TFM.addImage( "174f522620d.png", "$"..name, 0, -20)
            else
                player[name].wing = TFM.addImage( "174f525af4a.png", "$"..name, -35, -20)
            end
        end
    end
end

function getValue(theValue,c)
    return tonumber(theValue:match(('%s="([^"]+)"'):format(c))) or theValue:match(('%s="([^"]+)"'):format(c)) or theValue:match(('%s=""'):format(c))
end

function setPoints()
    local xml = maps[game.map.correntMap][3]
    for maplength in xml:gmatch("<P [^/]+/>") do
        local L = getValue(maplength,"L")
        game.map.l = L
        print(L)
    end
    for point in xml:gmatch("<O [^/]+/>") do
        local x = getValue(point,"X")
        local y = getValue(point,"Y")
        local c = getValue(point,"C")
        local p = getValue(point,"P")
        if c == 22 or c == 14 then
            if p == "0,0" then p = 0 else p = p:sub(0,2) end
            if c == 22 then c = 45 else c = -45 end
            jumpPoints[#jumpPoints+1] = {y = y , x = x , direction = c, p=p}
        elseif c == 12 then 
            respawnPoints.left[#respawnPoints.left + 1 ] = {x = x , y = y}
        elseif c == 13 then
            respawnPoints.right[#respawnPoints.right + 1 ] = {x = x , y = y}
        end
    end
end

function even_number(num)
    if num % 2  == 0 then 
        return 2
    else
        return 1
    end
end

function waves(wave)
    if wave <= 5 then 
        for i = 1,wave do 
            system.newTimer(function()
                zombie.spawn("skeleton", even_number(i))
            end, 1000*i, false)
        end
    else
        setMap()
    end
end

function updateBars(bar, name)
    if bar == "cheese" then
        local cheese = game.cheese
        local hp = game.cheese.hp / 100
        for i = 1,#game.cheese.images do
            if game.cheese.hp >= ((i/7)*100) then
                if imgs[1] then TFM.removeImage(imgs[1]) end
                imgs[1] = TFM.addImage(cheese.images[i],"_1000", cheese.x-80, cheese.y-35, nil)
            end
        end
        if game.cheese.hp < 0 then 
            if imgs[1] then TFM.removeImage(imgs[1]) end
            addTextArea(1, "", nil, 40, 42, 1 , 1, 0xFFBA25, 0xFFBA25, 1, true)
        else
            addTextArea(1, "", nil, 40, 42, 120 * hp , 1, 0xFFBA25, 0xFFBA25, 1, true)
        end
    elseif bar == "life" then
        local hp = player[name].hp / 100
        addTextArea( 2, "", name, 40, 85, 90 * hp, 1, 0xFE2538, 0xFE2538, 1, true)
        damaging(name)
    elseif bar == "fly" then
        local hp = player[name].fly / 100
        addTextArea(3, "", name, 40, 125, 70 * hp, 1, 0x50C0B7, 0x50C0B7, 1, true)
    end
end

function damaging(name)
    if name then 
        if player[name].hp <= 0 then 
            TFM.killPlayer(name)
        end
    elseif not name and game.cheese.hp <= 0 then
        if not game.over[2] then
            if not imgs[4] then imgs[4] = TFM.addImage(game.over[1],"&0",0,0,nil) end
            system.newTimer(function() TFM.removeImage(imgs[4]) setMap() game.over[2] = nil imgs[4] = nil end , 5000, false)
            game.over[2] = true
        end
    end
end

function flying(name)
    if player[name].flying then 
        if player[name].fly >= 20 then
            player[name].fly = player[name].fly - 20
            updateBars("fly", name)
            TFM.movePlayer(name, 0, 0, true, 0, -50, false)
            TFM.displayParticle(9, GET.room.playerList[name].x, GET.room.playerList[name].y)
        end
    end
end


function main()
    imgs.bonus = {}
    setMap(1)
    for _,c in pairs(game.commands) do
		system.disableChatCommandDisplay(c)
    end
    for name in pairs(GET.room.playerList) do
		eventNewPlayer(name)
	end
end

function updateMapName()
    TFM.setUIMapName(maps[game.map.correntMap][2].."<bl> - "..maps[game.map.correntMap][1].." | <fc>   Wave :</fc> "..game.wave.."<g>("..game.zombies.number..")")
end

function setMap(map)
    if not map then
        map = math.random(1,#maps)
    end
    if maps[tonumber(map)] then
        TFM.newGame(maps[tonumber(map)][3])
        updateMapName()
        game.map.correntMap = tonumber(map)
    end
end

main()
