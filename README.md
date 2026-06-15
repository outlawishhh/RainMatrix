# RainMatrix
A CMatrix skin for Rainmeter.

## Overview

RainMatrix recreates the iconic Matrix terminal aesthetic directly on your desktop using Rainmeter. The skin features animated binary streams, a terminal-style window, and a lightweight design that can be customized to fit your setup.

## Features

- Matrix-style animated character streams
- Custom terminal window interface
- Dynamic status messages
- Configurable dimensions and colors
- Lightweight and responsive
- Pure Rainmeter implementation
- No external plugins required

## Preview

https://github.com/user-attachments/assets/18e9527e-a0af-4610-bf02-f42ade89a303

## Installation

### Requirements

- Rainmeter 4.5 or higher
- Windows 10/11

### Setup

```bash
git clone https://github.com/outlawishhh/RainMatrix.git
```

Copy the `RainMatrix` folder into your Rainmeter skins directory:

```text
Documents/
└── Rainmeter/
    └── Skins/
        └── RainMatrix/
            ├── RainMatrix.ini
            └── RainMatrix.lua
```

Refresh Rainmeter and load the skin through the Rainmeter manager.

Refresh Rainmeter and load the skin through the Rainmeter manager.

#### Release Package

Prebuilt `.rmskin` package is available from the Releases page and can be installed directly through Rainmeter.


## Customization

Edit the variables section to customize the appearance:

```ini
[Variables]
MatrixWidth=350
MatrixHeight=300
MatrixColumns=10
BackColor=0,0,0,255
CharColor=0,255,0,255
FadeColor=0,180,0,150
TerminalTitle=Terminal
```

### Available Options

| Variable | Description |
|----------|-------------|
| MatrixWidth | Width of the terminal |
| MatrixHeight | Height of the terminal |
| MatrixColumns | Number of character streams |
| BackColor | Background color |
| CharColor | Primary character color |
| FadeColor | Trailing character color |
| TerminalTitle | Window title text |

## How It Works

The skin generates multiple independently animated binary streams using Rainmeter's built-in calculation measures. Each column operates at a different speed, creating a more natural Matrix-like effect while remaining lightweight.

## Credits

Created by **Outlawishhh**

Designed and implemented from scratch for Rainmeter.

## License

Copyright (C) 2026 Outlawishhh

Licensed under the GNU General Public License v3.0 (GPL-3.0).

You are free to use, modify, and redistribute this project under the terms of the GPL-3.0 license. Any distributed modifications must also remain open source and retain attribution to the original author.

See the [LICENSE](LICENSE) file for details.
