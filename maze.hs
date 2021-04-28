data Field
  = Start
  | Free
  | Wall
  | Exit
  deriving (Eq, Show)

fromChar :: Char -> Field
fromChar 'S' = Start
fromChar '.' = Free
fromChar '#' = Wall
fromChar 'E' = Exit

type Grid = [[Field]]

parseGrid :: String -> Grid
parseGrid = map parseRow . lines
  where
    parseRow :: String -> [Field]
    parseRow = map fromChar

type Position = (Int, Int)

at :: Grid -> Position -> Field
grid `at` (y, x) = (grid !! y) !! x

startPos :: Grid -> Position
startPos grid =
  head
    [ (y, x)
    | y <- [0 .. (length grid - 1)]
    , x <- [0 .. (length (grid !! y) - 1)]
    , grid `at` (y, x) == Start
    ]

data Direction
  = North
  | East
  | South
  | West
  deriving (Eq, Show)

allDirections = [North, East, South, West]

move :: Position -> Direction -> Position
move (y, x) North = (y - 1, x)
move (y, x) East  = (y, x + 1)
move (y, x) South = (y + 1, x)
move (y, x) West  = (y, x - 1)

type Path = [Direction]

dfs :: Grid -> [(Position, Path)] -> [Position] -> Maybe Path
dfs _ [] _ = Nothing
dfs grid ((pos, path):xs) visited =
  case grid `at` pos of
    Exit -> Just (reverse path)
