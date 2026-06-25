# FPGA Snake Game
A hardware implementation of Snake using Verilog HDL on the Terasic DE2-115 FPGA board.

## Overview
This project implements a Snake game completely in hardware using RTL design.
The FPGA generates VGA signals directly and handles game logic without a CPU or graphics library.

## Features
- 640x480 VGA output
- Custom VGA timing controller
- Pixel-based rendering
- Button controls
- Snake movement logic
- Food generation
- Hardware-based game loop

## Hardware
- Terasic DE2-115 FPGA
- VGA monitor
- Push buttons

## Architecture
Modules:
- vga_controller
- snake_logic
- renderer
- input_control
- game_tick

                   +----------------+
                 |   VGA Monitor  |
                 +-------▲--------+
                         |
                   VGA Signals
                         |
+---------+       +-------------+
| Buttons |-----> | Input Logic |
+---------+       +-------------+

                         |
                         v

                 +-------------+
                 | Snake Logic |
                 +-------------+

                         |
                         v

                 +-------------+
                 |  Renderer   |
                 +-------------+

                         |
                         v

                  Pixel Output

## Future Improvements
- Random food generation
- Collision detection
- Score display
