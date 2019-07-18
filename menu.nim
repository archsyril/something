import epic_games, epic_games/ [
  state, graphics, text, input
]
import config
import random

type
  Flake= tuple[x,y: int16, s: uint8]
  GameObj= object
    gb8, gb16: Font
    title: Text
    startGame, exitGame: Text
    marker, flake: Image
    keyId: uint8
    keyPos: array[2, int]
    flakes: array[0..128, Flake]
    fall: int16

state[GameObj] Menu
init Menu:
  gb8= "goldbox8".ttf 16
  gb16= "goldbox16".ttf 32
  title= White.text(GameName, gb16 )
  startGame= White.text("Start", gb8)
  exitGame= White.text("Exit", gb8)
  fall= 5
  marker= "enemy".png
  flake= "entity".png
  for i, f in flakes.mpairs():
    f.x= rand(-8..SWidth).int16
    f.y= rand(-8..SHeight).int16
    f.s= rand(32..90).uint8
  drawcolor(0,0,0)
  keyPos= [(SHeight-startGame.h*2-4).int, (SHeight-startGame.h-4).int]
free Menu:
  destroy(gb8)
  destroy(gb16)
  destroy(title)
  destroy(startGame)
  destroy(exitGame)
  destroy(marker)
draw Menu:
  clear()
  let
    x= if oneIn(16): rand(0..2)-1 else: 0
    y= if oneIn(16): rand(0..2)-1 else: 0
  for f in flakes:
    flake.colormod(f.s,f.s,f.s)
    flake.copy(f.x, f.y, 8)
  title.copy(4-x, SHeight-y-title.h-startGame.h*2-4)
  startGame.copy(24, SHeight-startGame.h*2-4)
  exitGame.copy(24, SHeight-startGame.h-4)
  marker.copy(4-y, keyPos[keyId], 16,16)
  present()
update Menu:
  for i, f in flakes.mpairs():
    f.x -= (f.s mod 6 + 2).int16
    f.y -= (f.s mod 6 + 2).int16
    if f.x < -12: f.x= SWidth+4
    if f.y < -12: f.y= SHeight+4
  if tapped(SC_W):   dec keyId
  elif tapped(SC_S): inc keyId
  if down(SC_SPACE):
    #[
    case range[0..1](keyId)
    of 0:
      machine.pullAll()
      machine.push(None)
    of 1: active= false
    ]#
    discard
  keyId= keyId mod 2
