
## Simple book gui for gmod made with html5

### Installation

Just place `book.lua` file at `.../lua/autorun/client/` folder

### Use

To create a book gui just follow an example below

```lua
local testbook = vgui.Create("Book")
testbook:Draw({
	title = "Test Title",
	subtitle = "Test Subtitle",
	pages = {
		"hello world page",
		[[
			<div align="center">
				Hello World!
				<br>
				<img src="https://i.imgur.com/S2lYrKD.gif" />
			</div>
		]]
	}
})
```

### Download

[Download book.lua](https://mestima.github.io/gmod/books/book.lua)