import epic_games, epic_games/state
import config

# initial state
import menu

var game: Game
if game.init(GameName, SWidth, SHeight):
  echo "hello"
  game.run(Menu)