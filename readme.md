# Ten bowling game

## Getting Started / Instalation

```
bundle install
```

## Project Structure

### games

Here, you can find every scenario posible from a game.

### lib

Contents the models where all the logic and data is being processed

* bowling = Display the scoreboard with every single data of the users involved in the game.
* frame = Process the data related with the scores, organizing them into its frames.
* frame_score = Calculates the score per frame.
* organizer = Separates scores into frames.
* scoreboard_table = Displays in a special form the scoreboard of the game
* user = reads the file where the scores are allocated


### spec

Contains the specs for every class.

## How to play the game
* Go to the folder where the project is via console. 
* Execute ruby lib/bowling.rb <name_of_the_file> i.e ruby lib/bowling.rb "games/perfect_game.txt"
*Execute in the console: ruby models/wrapper.rb <your_txt_file.txt>



##How to run specs
* To test an specific file, go to the folder where the project is. Then, execute rspec spec/lib/<name_file.rb>
* If you want to run all test, execute rspec inside the main folder.