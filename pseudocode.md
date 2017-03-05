# Pseucoding the solution
## Program flow
```
  Setup game board [Board]
    Initialize a 10 x 10 array [Board]
    Set initial flags to 10 [Board]
    Create 100 cells [Cell]
      10 of these cells should be Mines [Mine]
    Randomly distribute cells throughout the array [Board]
    Display initial board with all uncleared cells [Board]

  Start the game [Game]
    Loop while game is not lost (player has not "cleared a mine") or won (player has cleared all mines)
      
      Prompt player for action he wants to take (clear, flag, reset, quit)
      Loop until the player enters a valid action

      If the user chooses to clear
        Prompt player for coordinate of cell he wants to clear
        Validate that coordinate is valid (within range, cell is uncleared)
        Print appropriate message to screen if coordinate is invalid
        Loop until the player enters a valid coordinate
        Mark the cell as cleared
          If the cell is a Mine
            Print game over message to screen
            Reveal all mines on the board
            Ask player if he would like to play again
            If the player answers yes
              Reset game
            Else
              Print exit message to screen
              Exit program
          Else
            If all cells except those with mines have been cleared
              Reveal complete game board
              Print victory message
              Ask player if he would like to play again
              If the player answers yes
                Reset game
              Else
                Print exit message to screen
                Exit program
              
            Calculate how many adjacent mines the cleared cell has
            If there are no adjacent mines in the cell
              Mark the cell as blank
              Recursively calculate the number of adjacent mines for all adjacent cells
            Else
              Update the number of adjacent mines in the cell
        Display the current game board

      If the user chooses to flag
        Validate that there are still remaining flags
        If there are no remaining flags
          Return an error
          Prompt user for action again
        Else
          Prompt player for coordinate of cell he wants to flag
          Validate that coordinate is valid (within range)
          Loop until the player enters a valid coordinate
          If cell is unflagged
            Flag the cell
            Decrease remaining flags by 1
          Else
            Unflag the cell
            Increase remaining flags by 1
        Display the current game board

      If the user chooses to reset
        Print reset message to screen
        Reset the game

      If the user chooses to quit
        Print exit message to screen
        Exit program

```