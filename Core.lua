if not ModCore then
	log("[PDTH Menu V3] ERROR : ModCore from BeardLib is not present! Is BeardLib installed?")
	return
end

PDTHMenuV3 = PDTHMenuV3 or ModCore:new(ModPath .. "config.xml", true, true)

function PDTHMenuV3:init()
    self:log("Initialized.")
    self._initialized = true
end

function PDTHMenuV3:log(input, ...)
    if ... then
        log("[PDTHMenuV3] : " .. tostring(input), tostring(...))
        return
    end

    log("[PDTHMenuV3] : " .. tostring(input))
end

function PDTHMenuV3:Post(class, func, content)
    Hooks:PostHook(class, func, "PDTHMenuV3_Post_" .. tostring(func), content)
end

function PDTHMenuV3:Pre(class, func, content)
    Hooks:PreHook(class, func, "PDTHMenuV3_Pre_" .. tostring(func), content)
end

if not PDTHMenuV3._initialized then
    PDTHMenuV3:init()
end
