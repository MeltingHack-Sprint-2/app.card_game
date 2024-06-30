# UNO Game

Welcome to the UNO Game! This repository contains the implementation of the UNO card game with a backend written in Python and a frontend in Flutter.

## Table of Contents

- [UNO Game](#uno-game)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Game Rules](#game-rules)
    - [Objective](#objective)
    - [Setup](#setup)
    - [Gameplay](#gameplay)
    - [Drawing Cards](#drawing-cards)
    - [Winning the Game](#winning-the-game)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)

## Overview

UNO is a classic card game that is easy to learn but provides endless fun. This project allows you to play UNO in a 1-on-1 setting against another player. The game follows the standard rules of UNO with a few additional features.

## Game Rules

### Objective

The goal of UNO is to be the first player to get rid of all your cards. The first player to do so wins the game.

### Setup

1. Each player is dealt 7 cards.
2. The remaining cards form the draw pile.
3. The top card of the draw pile is turned over to start the discard pile.

### Gameplay

- **Starting Play**: The player to the left of the one who shuffled and dealt the cards starts the game. Play then proceeds clockwise.
- **Matching Cards**: Players must match a card in their hand with the card currently on the discard pile by either color or number.
- **Special Cards**:
  - **Skip**: The next player is skipped.
  - **Reverse**: Reverses the direction of play.
  - **Draw Two**: The next player draws two cards and loses their turn.
  - **Wild**: The player declares the next color to be matched.
  - **Wild Draw Four**: The player declares the next color to be matched, and the next player draws four cards and loses their turn. This card can only be played if the player has no other cards that can be played.

### Drawing Cards

- If you cannot play a card, you must draw a card from the draw pile.
- If the drawn card can be played, you may play it immediately.
- If the drawn card cannot be played, the turn passes to the next player.

### Winning the Game

- The first player to get rid of all their cards wins the game.

## Installation

### Prerequisites

- [Python 3.x](https://www.python.org/)
- [Flutter](https://flutter.dev/)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/)

## Getting Started

To start contributing to the frontend development, follow these steps:

1. Clone the repository:
    ```shell
    git clone https://github.com/MeltingHack-Sprint-2/app.card_game
    cd card_game
    ```
2. Set Up the Environment:
   Ensure you have Flutter installed on your machine. Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).
3. Install Dependencies:
    ```shell
    flutter pub get
    ```
4. Run the application:
    ```shell
    flutter run
    ```

Enjoy developing and playing the UNO game!