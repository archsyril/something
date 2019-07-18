const
  SWidth*  = 640
  SHeight* = 480
  GameName* = "Game Title"

template oneIn*(i: int): bool= rand(0..i) == 0