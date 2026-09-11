# Contents
This document links both original repos and local code samples that have been cleaned up and documented for show. Each section details my contributions and overviews of the code.

## Collaborative Repos
- [AI Food Reverse Image Search](#ai-food-reverse-image-search)
- [Gambling Game Prototype](#gambling-game-prototype)

## Personal Repos
- [MyTarot Digitization GUI](#mytarot-digitization-gui)
- [Gambler's Hand Discord Bot](#gamblers-hand-discord-bot)
- [Excel Macros](#biotek-data-grapher)
- [Skyscrapers Puzzle](#skyscrapers-puzzle)

# Repos

## [AI Food Reverse Image Search](https://github.com/MeadowMotz/AI-Food-RIS)
This web app was the result of a group project in my Deep Learning class in Spring 2025. We trained a ResNet50 model in python and built a FAISS index to search for similar images based on a query image’s features. 

My contributions were implementing the [search function](./code-samples/food-RIS/search.py), designing the [HTML site](./code-samples/food-RIS/site.html), and connecting both of them with a [RESTful API](./code-samples/food-RIS/server.py) using FastAPI.

## [Gambling Game Prototype](https://itch.io/jam/gambjam/rate/4058088)
This game was part of the Fall 2025 [UD Game Development Club's](https://github.com/UD-Game-Development-Club) game jam with the theme of *gambling*. It was intended to be a roguelike using RNG-based gambling modifiers/items. Due to the short timeframe and limited experience with Godot, our team only managed to make basic movement and HP scripts using sprites designed by one of the team members. The game jam ended along with the semester, and I departed for Australia shortly thereafter, unable to continue working on this game.

I was the team lead for this project. We used a [Figma board](./code-samples/gamb-jam/figma.png) (blurred for UDGD IP) for brainstorming and planning, and I set up a [Github project board](./code-samples/gamb-jam/git-issues.png) for task assignment. For all of the team members, there was a heavy learning curve for Godot and Git. As the most experienced programmer and team lead, I taught the rest of the team what I knew about Git and Godot, I managed pull requests in the Github repo, and I implemented the [movement](./code-samples/gamb-jam/movement.gd), [HP handling](./code-samples/gamb-jam/hurt_handling.gd), and [pathfinding scripts](./code-samples/gamb-jam/pathfinder.gd) in a branch before prototype submission.

## [MyTarot Digitization GUI](https://github.com/MeadowMotz/MyTarot-Cross)
This was intended to be a multi-platform digital tarot card manager application, but since I had no Mac, Android, or Linux devices or VMs to test the app on, I could only write for Windows and web. I programmed based on my [pseudocode](./code-samples/mytarot/Pseudo.txt) (ideas) and refined the Windows version. Due to time and workload constraints (with university), I had to put this project on hiatus. 

I wrote [back-end processing](./code-samples/mytarot/python.py) in Python with OpenCV to detect edges from an image of a tarot card, draw a quadrilateral around those edges, and apply a homography using the points. I designed an [animated front-end](./code-samples/mytarot/main.dart) application using Flutter and Dart to [manage](./code-samples/mytarot/EditorPage.dart), [display](./code-samples/mytarot/DecksPage.dart), and [draw](./code-samples/mytarot/DrawPage.dart) digital cards, and I hooked it to the back-end [using JSON dumps](./code-samples/mytarot/python.dart).


## [Gambler's Hand Discord Bot](https://github.com/MeadowMotz/Gamblers-Hand)
This ongoing project is meant to automate the dice rolling for my Dungeons and Dragons (DND) 5th Edition homebrew spell called "[Gambler's Hand](./code-samples/gamblers-hand/spell.txt)". The spell is designed to attack enemies with playing cards using poker rules, but because each card needs 2+ rolls each to calculate damage, it was impractical with physical dice.

I started by creating a [CLI](./code-samples/gamblers-hand/gamblers_hand_cli.py) in Python that accepts the user's DND stats, automates dice rolling, and calculates card values and damage based on the spell rules. I am currently designing a [Discord bot](./code-samples/gamblers-hand/gamblers_hand_bot.py) with discord.py and Discord API to respond to commands in an easier to read format located where my DND campaign is hosted online.

## [Biotek Data Grapher](https://github.com/MeadowMotz/Personal-Projects/tree/main/Excel/Biotek%20Easy%20Grapher)
During my Research Experience for Undergraduates (REU) at Central State University during summer 2025, my mentors and research team were working with large Excel datasets from a Biotek spectrophotometer. I saved them time in manual statistical and graphical analysis by automating repeated statistical functions and graph constructions with an [Excel macro](./code-samples/biotek-grapher/macro.bas) in Microsoft VBA. When test data points had noise, I [removed it](./code-samples/biotek-grapher/DeNoise.bas) using the control data to better highlight changes across time.

## [Skyscrapers Puzzle](https://github.com/MeadowMotz/Personal-Projects/tree/main/JS/Skyscrapers)
While I was volunteering to help host a mathematics competition for the UD Math Club, I discovered a puzzle/problem called "Skyscrapers". It is comprised of a square table with numbers at the edges.  The table cells are filled by the user with numbers that represent the height of the skyscraper. Its rules are: 1) an edge number indicates how many skyscrapers can be seen from that point down the row/column. 2) a skyscraper can be seen if it is taller (higher number) than all the skyscrapers in front of it (towards viewpoint/edge number).

With the advice of my professor and AI, I attempted to learn and create a generator and a solver for this puzzle [in Javascript](./code-samples/skyscrapers/code.js) using recursive backtracking. I designed a [basic HTML site](./code-samples/skyscrapers/ui.html) to visualize and interact with the puzzle, and the Javascript animated the table while the algorithm solved the puzzle. I encountered bugs in the solving that were likely due to faulty puzzle generation, but I abandoned this project to focus on my university final assignments.
