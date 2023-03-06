local bad_words = {
    -- Spanish
    "cajetuda",
    "cabron",
    "culo",
	"pija",
	"puta",
	"puto",
	"perra",
	"concha",
	"cajeta",
	"mierda",
	"pelotudo",
	"pelotuda",
	"boludo",
	"boluda",
	"verga",
	"pene",
	"pito",
	"poronga",
	"joder",
	"hostia",
	"idiota",
	"gey",
	"homosexual",
	"sexo",
	"tonto",
	"violado",
	"violada",
	"pajero",
	"estupido",
	"gilipollas",
	"pollas",
	"chupapollas",
	"coño",
	"esperma",
	"follador",
	"follar",
	"imbecil",
	"jilipollas",
	"kapullo",
	"maldito",
	"mamada",
	"marica",
	"maricon",
	"nazi",
	"ramera",
	"semen",
	"tetas",
	"travesti",
	-- English
	"anus",
	"arse",
	"ass",
	"bastard",
	"biatch",
	"bitch",
	"damn",
	"dildo",
	"fuck",
	"fck",
	"poop",
	"penis",
	"piss",
	"pussy",
	"shit",
	"vagina",
}

local white_words = {
    "calculo",
	"compass",
	"pass",
}

local function contains_bad_word(message)
    for _, word in ipairs(bad_words) do
        if string.find(message, word) then
            return true
        end
    end
    local consecutive_chars = {}
    local last_char = ""
    for char in message:gmatch(".") do
        if char ~= last_char and last_char ~= "" then
            consecutive_chars = {}
        end
        consecutive_chars[char] = (consecutive_chars[char] or 0) + 1
        if consecutive_chars[char] > 6 then
            return true
        end
        last_char = char
    end
    return false
end

minetest.register_on_chat_message(function(name, message)
    if contains_bad_word(message) then
        for _, word in ipairs(white_words) do
            if string.find(word, message) then
                return false
            end
        end
        minetest.chat_send_player(name, minetest.colorize("red", "*** Server: You have insulted or your message contains spam! Please avoid sending repeated characters and do not abuse the chat or you will be punished."))
        return true
    end
end)
