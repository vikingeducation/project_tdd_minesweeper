# Pseudocoding the solution
## Program flow
```
  Setup game board [Board]
    Initialize a 10 x 10 array [Board]
    Set initial flags to 10 [Board]
    Create 100 cells [Cell]
      10 of these cells should have mines [Cell]
    Randomly distribute cells throughout the array [Board]
    Display initial board with all uncleared cells [Renderer]

  Start the game [Game]
    Print game instructions to player [Game]
    Loop while game is not lost (player has not "cleared a mine") or won (player has cleared all mines) [Game]
      
      Prompt player for action he wants to take (clear, flag, reset, quit) [Player]
      Loop until the player enters a valid action [Player]

      If the user chooses to clear
        Prompt player for coordinate of cell he wants to clear [Player]
        Validate that coordinate is valid (within range, cell is uncleared) [Board]
        Print appropriate message to screen if coordinate is invalid [Renderer]
        Loop until the player enters a valid coordinate [Player]
        Check if the cell has a mine [Cell]
          If the cell has a mine
            Print game over message to screen [Game]
            Reveal all cells with mines on the board [Renderer]
            Ask player if he would like to play again [Player]
            If the player answers yes
              Reset game [Game]
            Else
              Print exit message to screen [Game]
              Exit program [Game]
          Else
            If all cells except those with mines have been cleared
              Reveal complete game board [Renderer]
              Print victory message [Game]
              Ask player if he would like to play again [Player]
              If the player answers yes
                Reset game [Game]
              Else
                Print exit message to screen [Game]
                Exit program [Game]
            
            Else (not all safe cells have been cleared)  
              Calculate how many adjacent mines the cleared cell has [Board]
              If there are no adjacent mines in the cell
                Mark the cell as blank [Cell]
                Recursively calculate the number of adjacent mines for all adjacent cells [Board]
              Else
                Update the number of adjacent mines in the cell [Cell]
              Display the current game board [Renderer]

      If the user chooses to flag
        Validate that there are still remaining flags [Board]
        If there are no remaining flags
          Print appropriate message to screen [Renderer]
          Prompt user for action again [Player]
        Else
          Prompt player for coordinate of cell he wants to flag [Player]
          Validate that coordinate is valid (within range) [Board]
          Loop until the player enters a valid coordinate [Player]
          If cell is unflagged
            Set the cell as flagged [Cell]
            Decrease remaining flags by 1 [Board]
          Else
            Set the cell as uncleared [Cell]
            Increase remaining flags by 1 [Board]
        Display the current game board [Renderer]

      If the user chooses to reset
        Print reset message to screen [Game]
        Reset the game [Game]

      If the user chooses to quit
        Print exit message to screen [Game]
        Exit program [Game]

```

## Notes to self
1. The Cell class should have a means to determine what state the cell is in, i.e is it uncleared / cleared / flagged / contains a mine