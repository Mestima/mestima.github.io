
local w, h = ScrW()/2, ScrH()/2

local PANEL = {}

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
end

--[[
	local data = {
		pages = {},
		title = "",
		subtitle = ""
	}
]]--

function PANEL:Draw(dta)
	local data = dta
	if !data then data = {} end
	if !data.pages then data.pages = {""} end
	if !data.title then data.title = "" end
	if !data.subtitle then data.subtitle = "" end
	local content = ""
	for i = 2, #data.pages, 2 do
		content = content .. string.format([[
			<div class="bb-item">
				<div class="bb-custom-side">
					<p>%s</p>
				</div>
				<div class="bb-custom-side">
					<p>%s</p>
				</div>
			</div>
		]], data.pages[i], data.pages[i+1] || "")
	end
	
	self.page = vgui.Create("DHTML", self)
	self.page:Dock(FILL)
	self.page:SetHTML(string.format([[
	<!DOCTYPE html>
	<html lang="en" class="no-js main">
		<head>
			<meta charset="UTF-8" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
			<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
			<link rel="stylesheet" type="text/css" href="https://mestima.github.io/gmod/books/css/default.css" />
			<link rel="stylesheet" type="text/css" href="https://mestima.github.io/gmod/books/css/bookblock.css" />
			<link rel="stylesheet" type="text/css" href="https://mestima.github.io/gmod/books/css/style.css" />
			<script src="https://mestima.github.io/gmod/books/js/modernizr.custom.js"></script>
		</head>
		<body>
			<div class="container">
				<div class="bb-custom-wrapper">
					
					<div id="bb-bookblock" class="bb-bookblock">
						<div class="bb-item">
							<div class="bb-custom-firstpage">
								<h1>%s<span>%s</span></h1>
							</div>
							<div class="bb-custom-side">
								<p>%s</p>
							</div>
						</div>
	]], data.title, data.subtitle, data.pages[1]) .. content .. [[
					</div>

					<nav>
						<a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first">First page</a>
						<a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left">Previous</a>
						<a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right">Next</a>
						<a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last">Last page</a>
					</nav>

				</div>

			</div>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
			<script src="https://mestima.github.io/gmod/books/js/jquerypp.custom.js"></script>
			<script src="https://mestima.github.io/gmod/books/js/jquery.bookblock.min.js"></script>
			<script>
				var Page = (function() {
					
					var config = {
							$bookBlock : $( '#bb-bookblock' ),
							$navNext : $( '#bb-nav-next' ),
							$navPrev : $( '#bb-nav-prev' ),
							$navFirst : $( '#bb-nav-first' ),
							$navLast : $( '#bb-nav-last' )
						},
						init = function() {
							config.$bookBlock.bookblock( {
								speed : 1000,
								shadowSides : 0.8,
								shadowFlip : 0.4
							} );
							initEvents();
						},
						initEvents = function() {
							
							var $slides = config.$bookBlock.children();

							config.$navNext.on('click touchstart', function() {
								config.$bookBlock.bookblock( 'next' );
								return false;
							});

							config.$navPrev.on('click touchstart', function() {
								config.$bookBlock.bookblock( 'prev' );
								return false;
							});

							config.$navFirst.on('click touchstart', function() {
								config.$bookBlock.bookblock( 'first' );
								return false;
							});

							config.$navLast.on('click touchstart', function() {
								config.$bookBlock.bookblock( 'last' );
								return false;
							});
							
							$slides.on({
								'swipeleft' : function( event ) {
									config.$bookBlock.bookblock( 'next' );
									return false;
								},
								'swiperight' : function( event ) {
									config.$bookBlock.bookblock( 'prev' );
									return false;
								}
							});

							$(document).keydown(function(e) {
								var keyCode = e.keyCode || e.which,
									arrow = {
										left : 37,
										up : 38,
										right : 39,
										down : 40
									};

								switch (keyCode) {
									case arrow.left:
										config.$bookBlock.bookblock('prev');
										break;
									case arrow.right:
										config.$bookBlock.bookblock('next');
										break;
								}
							});
						};
						return {init : init};
				})();
			</script>
			<script>
					Page.init();
			</script>
		</body>
	</html>
	]])
end

function PANEL:Init()
    self:SetSize(w , h)
    self:SetPos(w/2, h/2)
	self:SetTitle("")
	self:MakePopup()
end

vgui.Register("Book", PANEL, "DFrame")
