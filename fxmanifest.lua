fx_version 'adamant'
game 'gta5'
description 'Velocity Speedo System'

ui_page "html/html.html"

files {
	"html/html.html",
	"html/*.js",
	"html/*.svg",
	"html/*.ttf",
	"html/*.png",
	"html/*.css"
}

client_scripts {
	"client.lua",
}

shared_script '@epm-ac/secly.lua'