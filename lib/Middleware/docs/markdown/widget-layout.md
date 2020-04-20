## Widget Layout
### Description

A widget, at minimum, comprises of a single file: `index.html`. From there, you are free to add whatever resources your widget requires, such as images and styling.

You can add an additional `config.json` file, which defines some metadata to display in the UI shown to users when picking widgets. In a future update, this will also be where you specify configuration layouts for users to adjust.

Furthermore, you can also bundle a `Screenshot.png` file, which is shown to users when picking widgets. This should be sized at maximum `200x200` pixels.

#### Example structure:

`Widget Folder Name`

↳ `index.html`

↳ `config.json` (optional)

↳ `Screenshot.png` (optional)

### `config.json`

This file is set out like a `package.json` file from NPM modules. For now, the following keys are recognised:

- `name`
    - The name of the widget, if different from the folder name
- `author`
    - The author's name

### Install Locations

Widgets can be installed in one central place on the user's filesystem: `/var/mobile/Library/Widgets`.

This folder contains four (4) sub-folders:

- `Backgrounds`
    - Contains widgets that act like device backgrounds.
    - They can only be applied via the background option for the Lockscreen and Homescreen.
- `Homescreen`
    - Contains widgets that are specific to the Homescreen, but can be placed in the foreground or background.
- `Lockscreen`
    - Contains widgets that are specific to the Lockscreen, but can be placed in the foreground or background.
- `Universal`
    - Contains widgets that may be placed anywhere.

Additionally, legacy widgets are also loaded into the UI shown to users when picking widgets. These are read from the following locations:

- `SBHTML`
- `LockHTML`
- `iWidgets`
- `GroovyLock`

It is **strongly** recommended to install newly created widgets into the central folder heirarchy, detailed above.