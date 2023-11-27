clc
clear
close all

% Setting the figure to "fig" so it can be modified later
fig = figure;

% simpleGameEngine initialization
game_scene = simpleGameEngine('2048sprite.png', 84, 84, 5, [207, 198, 184]);

% variables initialized as global to store the sprite index values for each tile number
% while allowing the sprite indicies to be accessed and modified in any function.
global icon2 icon4 icon8 icon16 icon32 icon64 icon128 icon256 icon512 icon1024 icon2048 iconBlank

% Defining variables relative to the game based on the sprite sheet
icon2 = 1;
icon4 = 2;
icon8 = 3;
icon16 = 4;
icon32 = 5;
icon64 = 6;
icon128 = 7;
icon256 = 8;
icon512 = 9;
icon1024 = 10;
icon2048 = 11;
iconGameOver = 12;
iconBlank = 13;


% Initialize empty 4x4 game board using "iconBlank" sprite indices 
global board numEmptyTiles
board = [iconBlank, iconBlank, iconBlank, iconBlank;
         iconBlank, iconBlank, iconBlank, iconBlank;
         iconBlank, iconBlank, iconBlank, iconBlank;
         iconBlank, iconBlank, iconBlank, iconBlank];

% Initial tile count
numEmptyTiles = 16;


% "CurrentCharacter" is used to store the last key pressed on the figure
% and this is setting the CurrentCharacter to 0 indicating that no key has
% been pressed
set(fig, 'CurrentCharacter', '0'); % Initialize CurrentCharacter

% Main game loop
while (true)

drawScene(game_scene, icon2048) % Drawing the gamescene with the 2048 icon
% Initial messages
title('Team C''s 2048 GAME', 'FontSize', 20)
xlabel('PRESS ANYWHERE TO START')
waitforbuttonpress; 
board = [iconBlank, iconBlank, iconBlank, iconBlank;  % Start the game with a blank board
         iconBlank, iconBlank, iconBlank, iconBlank;
         iconBlank, iconBlank, iconBlank, iconBlank;
         iconBlank, iconBlank, iconBlank, iconBlank];

board = startGameTiles(board); % Initial tile placement

drawScene(game_scene, board);  
% Update the title and xlabel
title('Can you get to 2048!?','FontSize', 15)
xlabel('Use w/a/s/d keys to shift tiles', 'FontSize', 14)

while true
    pause(0.1); % Small delay for tile movement

    key = get(gcf, 'CurrentCharacter'); % Gets the current key press stored in the figure
    if key ~= '0' % Check if a key is pressed
        [board, numEmptyTiles] = processKey(key, board, numEmptyTiles); % Calls the processKey function to handle the key press 
        set(gcf, 'CurrentCharacter', '0'); % Reset the character
       
           
            disp(board);  % Display the current state of the board
            drawScene(game_scene, board); % Redraw the game scene
       
    end
% If there are no more empty tiles and the "isGameOver" condition is true,
% the game ends and the loop is broken out of
    if numEmptyTiles == 0 && isGameOver(board)
        drawScene(game_scene, iconGameOver)
        title('You Lose!','FontSize',20);
        xlabel('y to play again, n to quit','FontSize',14)
        break;
    end
end

playAgain = input('Would you like to play again?', "s")
xlabel('y to play again, n to quit','FontSize',14)
if playAgain ~= 'y'
break;
end

end
% Define the processKey function
% Takes in the key, current board state, and number of empty tiles and
% returns the newBoard and an updated number of empty tiles
function [newBoard, updatedNumEmptyTiles] = processKey(key, board, numEmptyTiles)
    global iconBlank
    prevBoard = board; % first save the original board
   % strcmp used to handle different key presses between w/a/s/d
        % w or W key calls the shiftTiles and mergeTiles functions in the up
        % direction
        if strcmp(key, 'w') || strcmp(key, 'W')
        board = shiftTiles(board, 'up');
        board = mergeTiles(board, 'up');
        % a or A key calls the shiftTiles and mergeTiles functions in the left
        % direction
        elseif strcmp(key, 'a') || strcmp(key, 'A')
        board = shiftTiles(board, 'left');
        board = mergeTiles(board, 'left'); 
        % s or S key calls the shiftTiles and mergeTiles functions in the down
        % direction
        elseif strcmp(key, 's') || strcmp(key, 'S') % Down
        board = shiftTiles(board, 'down');
        board = mergeTiles(board, 'down');
        % d or D key calls the shiftTiles and mergeTiles functions in the right
        % direction
        elseif strcmp(key, 'd') || strcmp(key, 'D') % Right
        board = shiftTiles(board, 'right');          
        board = mergeTiles(board, 'right');
       % For other key presses, the board isn't changed and the loop is
       % re-iterated
        else
            newBoard = board;
            updatedNumEmptyTiles = numEmptyTiles;
            return;
    end
      % If the board was changed (valid key press), Call the addNewTile
      % function
    if ~isequal(board, prevBoard)
        [newBoard, updatedNumEmptyTiles] = addNewTile(board);
    else
        newBoard = board;
        updatedNumEmptyTiles = numEmptyTiles;
    end
end

% Function shifts board tiles in the specificied direction
% Takes board and direction as inputs and returns an updated board with
% shifted tiles
function board = shiftTiles(board , direction)

global iconBlank

 
% If direction is up
if strcmp(direction, 'up')  
 for j = 1:size(board,2) % Loop through columns
  for i = 2:size(board, 1) % Loop through rows besides top 
   if board(i,j) ~= iconBlank % If the tile isn't blank
   k = i - 1; % Store the index of the tile above
    while k > 0 && board(k,j) ==  iconBlank % Shift the tile up as long as the space above is blank
    board(k,j) = board(i,j); % Shift tile value up
    board(i,j) = iconBlank; % Set current tile blank
    i = k; % update index to shifted position
    k = k - 1; % decrement index to check next position
end
end
end
end

elseif strcmp(direction, 'left')
 for i = 1:size(board,1) % Loop through rows
  for j = 2:size(board,2) % Loop through columns besides leftmost
   if board(i,j) ~= iconBlank % If the tile isn't blank
    k = j-1; % Store index of tile to the left
     while k > 0 && board(i,k) == iconBlank % Shift left as long as space to left is blank
     board(i,k) = board(i,j); % Shift tile left
     board(i,j) = iconBlank; % Set current tile blank
     j = k; % Update index
     k = k-1; % decrement to check next position
end
end
end
end

elseif strcmp(direction, 'down')
 for j = 1:size(board, 2)  % Loop through columns
  for i = size(board, 1)-1:-1:1 % Loop rows besides bottom 
   if board(i, j) ~= iconBlank % If the tile isn't blank
   k = i + 1;  % Store index of tile below
    while k <= size(board, 1) && board(k, j) == iconBlank % Shift down as long as space below is blank
    board(k, j) = board(i, j); % Shift tile down
    board(i, j) = iconBlank % Set current tile blank
    i = k; % Update index
    k = k + 1; % decrement to check next position
end
end
end
end

elseif strcmp(direction, 'right')
 for i = 1:size(board,1) % Loop through rows
  for j = size(board,2):-1:1 % Loop through columns besides rightmost
   if board(i,j) ~= iconBlank % If the tile isn't blank
   k = j+1;  % Store index of tile to right
    while k <= size(board,2) && board(i,k) == iconBlank % Shift right as long as space to right is blank
    board(i,k) = board(i,j) % Update index
    board(i,j) = iconBlank; % Set current tile blank
    j = k; % Update index
    k = k+1; % decrement to check next position

end
end
end
end
end
end

% function merges touching tiles in the specified direction
% Takes board and direction as inputs and outputs an updated board
function board = mergeTiles(board, direction)
% Global sprite index values so they can be accessed
    global iconBlank icon2 icon4 icon8 icon16 icon32 icon64 icon128 icon256 icon512 icon1024 icon2048

% If direction is up
if strcmp(direction, 'up')
 for j = 1:size(board, 2) % Loop through columns
  for i = 1:size(board, 1)-1 % Loop through rows besides bottom row
   if board(i, j) == board(i+1, j) && board(i, j) ~= iconBlank % If touching tiles are the same and not blank
   board(i, j) = getNextIconIndex(board(i, j)); % Merge the tiles by updating the sprite index
   board(i+1, j) = iconBlank; % Set merged tile position to blank
   end           
end
end

% Same logic as above

elseif strcmp(direction, 'left')
 for i = 1:size(board, 1)
  for j = 1:size(board, 2)-1
   if board(i, j) == board(i, j+1) && board(i, j) ~= iconBlank
   board(i, j) = getNextIconIndex(board(i, j));
   board(i, j+1) = iconBlank;
end
end
end

% Same logic as above
elseif strcmp(direction, 'down')
 for j = 1:size(board, 2)
  for i = size(board, 1):-1:2
   if board(i, j) == board(i-1, j) && board(i, j) ~= iconBlank
   board(i, j) = getNextIconIndex(board(i, j));
   board(i-1, j) = iconBlank;
end
end
end
 
% Same logic as above
elseif strcmp(direction, 'right')
 for i = 1:size(board, 1)
  for j = size(board, 2):-1:2
   if board(i, j) == board(i, j-1) && board(i, j) ~= iconBlank
   board(i, j) = getNextIconIndex(board(i, j));
   board(i, j-1) = iconBlank;
end
end
end
end
end

% function gets the next sprite index after merging tiles
% takes the current sprite index as an input and returns the next icon
function nextIcon = getNextIconIndex(currentIcon)
 % Global variables so they can be accessed
    global iconBlank icon2 icon4 icon8 icon16 icon32 icon64 icon128 icon256 icon512 icon1024 icon2048

% Returns the next index which is double the previous icon
     if currentIcon == icon2
        nextIcon = icon4;
    elseif currentIcon == icon4
        nextIcon = icon8;
    elseif currentIcon == icon8
        nextIcon = icon16;
    elseif currentIcon == icon16
        nextIcon = icon32;
    elseif currentIcon == icon32
        nextIcon = icon64;
    elseif currentIcon == icon64
        nextIcon = icon128;
    elseif currentIcon == icon128
        nextIcon = icon256;
    elseif currentIcon == icon256
        nextIcon = icon512;
    elseif currentIcon == icon512
        nextIcon = icon1024;
    elseif currentIcon == icon1024
        nextIcon = icon2048;
    elseif currentIcon == icon2048
        nextIcon = icon2048; 
        isGameOver = true;
        title('You Win!!!!!')
     else
        nextIcon = currentIcon;
    end
end

% function adds a new '2' tile to the board
% Takes the board as an input and returns an updated board and the number
% of empty tiles remaining
function [newBoard, updatedNumEmptyTiles] = addNewTile(board)
    global icon2 iconBlank

    emptyTiles = find(board == iconBlank); % Finds the indicies of empty tiles
    if isempty(emptyTiles) % If no empty tiles, return unchanged
        newBoard = board;
        updatedNumEmptyTiles = 0;
        return;
    end
    randomTile = emptyTiles(randi(length(emptyTiles))); % Picks a random empty tile
    board(randomTile) = icon2; % Sets that random blank to '2'
    newBoard = board; % Updates the board
    updatedNumEmptyTiles = numel(emptyTiles) - 1; % decreases number of empty tiles by 1
end

% Function adds the two initial tiles to start the game
% takes board and number of tiles as a inputs and returns an updated board
function board = startGameTiles(board)
    global icon2 iconBlank
    % Same logic as addNewTile function
    for i = 1:2 % Loops twice
        emptyTiles = find(board == iconBlank); 
        randomTile = emptyTiles(randi(length(emptyTiles)));
        board(randomTile) = icon2;
    end
end

% Function checks if the game is over (no moves left)
function gameOver = isGameOver(board)
    global iconBlank  
    % Checks if any blank icons are left and if any merges are possible
    gameOver = all(board(:) ~= iconBlank) && ~canMerge(board);
end

% Function checks if any merges are possible
function canMerge = canMerge(board)
    global iconBlank
    canMerge = false; 

    % Check if any touching cells can merge horizontally
for i = 1:size(board, 1)
 for j = 1:size(board, 2)-1
  if board(i, j) == board(i, j+1) && board(i, j) ~= iconBlank
  canMerge = true;
  return;
end
end
end
    % Checks if any touching cells can merge vertically
for j = 1:size(board, 2)
 for i = 1:size(board, 1)-1
   if board(i, j) == board(i+1, j) && board(i, j) ~= iconBlank
   canMerge = true;
   return;
end
end
end
end