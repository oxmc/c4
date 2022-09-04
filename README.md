# C4

Computer Craft Code Catalog (C4), a ComputerCraft dependency manager

## Getting Started

1. Open a brand-new computer. You should see a command-line interface.
2. Type `edit install_c4.lua`. You should be taken to a text editor.
3. Copy/paste the following into the text editor:

```
local request = http.get(("https://raw.githubusercontent.com/oxmc/c4/main/c4.lua?cb=%x"):format(math.random(0, 2 ^ 30)))
local file = fs.open("c4", "w")
file.write(request.readAll())
file.close()
```

* Note, you may need to copy/paste the code one line at a time, unfortunately.

4. Press `ctrl`. You should see `Save` and `Exit` along the bottom.
5. Make sure `Save` is selected and press the `enter` key. This will save the file.
6. Press `ctrl` again, and select Exit. You should now be taken back to the command-line interface.
7. Run the installer: `install_c4"

Now you can load C4 applications and libraries.

## Usage

`c4 hello`

`c4 <APPLICATION_NAME>`
