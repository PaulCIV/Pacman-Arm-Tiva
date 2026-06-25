# Pac-Man for ARM Cortex-M4 (TM4C123)

![ARM Assembly](https://img.shields.io/badge/ARM-Assembly-A6120D)
![Embedded Systems](https://img.shields.io/badge/Embedded-Systems-success)
![TM4C123](https://img.shields.io/badge/TM4C123-Tiva%20C-blue)
![UART](https://img.shields.io/badge/UART-Terminal-orange)
![GPIO](https://img.shields.io/badge/GPIO-Hardware-yellowgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

A fully playable Pac-Man clone developed by a two man team in ARM Thumb assembly for the TM4C123 (Tiva C Series) microcontroller. The project demonstrates low-level embedded programming through direct hardware interaction, interrupt-driven game logic, UART terminal graphics, and memory-mapped peripheral control.

# Overview

This project recreates Pac-Man on an ARM Cortex-M4 microcontroller using ARM assembly language.

Rather than relying on a game engine or operating system, every major component—including rendering, input handling, timers, game state management, collision detection, ghost behavior, and hardware initialization—is implemented directly on bare-metal hardware.

The game executes on a TM4C123 microcontroller while rendering graphics through a UART serial terminal using ANSI escape sequences.


# Features

## Gameplay

- Fully playable Pac-Man
- Pellet collection
- Power pellets
- Score tracking
- Multiple lives
- Pause and resume
- Restart functionality
- Game over handling
- Level progression

## Ghost AI

Four independently controlled ghosts:

- Blinky
- Pinky
- Inky
- Clyde

Features include:

- Individual movement state
- Spawn behavior
- Direction tracking
- Randomized path selection
- Scared mode
- Respawn after being eaten

## Graphics

The game is rendered entirely through a UART serial terminal using ANSI escape sequences.

Rendering includes:

- Colored sprites
- Cursor positioning
- Colored maze
- Dynamic score display
- Status messages
- Animated movement

## Embedded Hardware

The project directly interfaces with TM4C123 peripherals including:

- UART communication
- GPIO
- Push buttons
- LEDs
- RGB LED
- Hardware timers
- Interrupt controller

All peripherals are configured through memory-mapped registers using ARM assembly.

# Technology Stack

## Hardware

- TM4C123GH6PM (Tiva C Series)
- ARM Cortex-M4

## Programming

- ARM Thumb Assembly
- C (startup wrapper)

## Embedded Concepts

- Memory-mapped I/O
- Interrupt-driven programming
- UART communication
- GPIO configuration
- Hardware timers
- Register-level programming

---

# Architecture

```text
                  TM4C123 Microcontroller
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
     UART Driver       GPIO Driver      Timer Interrupts
        │                  │                  │
        └──────────────┬───┴──────────────────┘
                       ▼
                  Game Engine
                       │
      ┌────────────────┼────────────────┐
      │                │                │
      ▼                ▼                ▼
 Pac-Man Logic     Ghost AI       Collision System
      │                │
      └────────────┬───┘
                   ▼
            ANSI Terminal Output
```

# Core Systems

## Hardware Initialization

- UART configuration
- GPIO initialization
- Timer setup
- Interrupt initialization
- LED configuration

## Rendering Engine

- ANSI cursor positioning
- Colored sprite rendering
- Board drawing
- Dynamic updates
- Terminal animation

## Game Engine

- Main game loop
- Tick-based updates
- Input processing
- Collision detection
- Score management
- Win/loss conditions

## Ghost AI

Each ghost maintains independent state including:

- Position
- Direction
- Spawn state
- Scared state
- Movement decisions

Ghost behavior changes dynamically depending on game state and power pellet activation.

# Challenges

Key engineering challenges included:

- Developing a complete game almost entirely in ARM assembly
- Managing game state without high-level language abstractions
- Implementing UART graphics using ANSI escape sequences
- Coordinating interrupt-driven timing with gameplay updates
- Programming directly against hardware registers
- Managing memory manually
- Debugging low-level assembly code

My Contributions

This project was developed collaboratively as a two-person embedded systems project.

Development responsibilities were divided approximately evenly across both team members, with each contributing to the design, implementation, debugging, and hardware integration of the final system.

Because development was highly collaborative and responsibilities evolved throughout implementation, individual ownership of specific modules are not specified. Together, we designed and implemented the complete embedded game, integrating ARM assembly, UART communication, hardware peripherals, interrupt-driven programming, and gameplay mechanics into a single working system.

# Lessons Learned

This project provided practical experience with:

- ARM Cortex-M assembly programming
- Embedded systems development
- Hardware abstraction
- Interrupt-driven software
- Register-level peripheral control
- Real-time game programming
- Low-level debugging

# Future Improvements

Potential enhancements include:

- More authentic ghost pathfinding
- Additional levels
- Sound effects
- Hardware display support
- Higher frame rate rendering
- Optimized assembly routines
- Configurable difficulty

# Project Status

Completed as an embedded systems project demonstrating ARM assembly programming.
