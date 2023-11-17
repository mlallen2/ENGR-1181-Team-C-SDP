clc
clear
close all

% simpleGameEngine initialization
game_scene = simpleGameEngine('2048sprite.png', 84,84,5, [207,198,184]);


% Defining what each sprite represents
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
iconBlank = 12;

board = [iconBlank,iconBlank,iconBlank,iconBlank;
iconBlank,iconBlank,iconBlank,iconBlank;
iconBlank,iconBlank,iconBlank,iconBlank;
iconBlank,iconBlank,iconBlank,iconBlank;];


drawScene(game_scene,board);
title('Team C''s 2048 GAME')
xlabel('PRESS ANYWHERE TO START')


waitforbuttonpress; %waits for a button press before starting the game
xlabel('') 

numEmptyTiles = 16

for i = 1:2 % loops twice for two tile placements
    emptyTiles = find(board == iconBlank); %finds tiles that are empty
    randomTile = emptyTiles(randi(length(emptyTiles))); % selects the random tile from the selection of empty tiles
    board(randomTile) = icon2; % places a 2 icon in the selected random tile on the board
    drawScene(game_scene, board); % draws the new board
    pause(0.2); % slightly pause to visualize the placement
end

numEmptyTiles = 14

drawScene(game_scene,board);


% Main game loop


% Main game loop
while numEmptyTiles > 0
    waitforbuttonpress; % REPLACE WITH KEYBOARD INPUT (W/A/S/D)
    [board, numEmptyTiles] = addNewTile(board); % Update the board and numEmptyTiles
    drawScene(game_scene, board);
numEmptyTiles 
    if numEmptyTiles == 0 % If the board is full, The game ends and "Game Over" is displayed
        title('GAME OVER')
    end
end  

function board = shiftTiles(board , direction)
switch direction
    case 'up'
   for i = 2:size(board, 1)
    for j = 1:size(board,2)
     if board(i,j) ~= iconBlank
     k = i - 1;
while k > 0 && board(k,j) ==  iconBlank
 board(k,j) = board(i,j);
 board(i,j) = iconBlank;
 i = k;
 k = k - 1;
end
     end
    end
   end
     case 'left'
      for i = 1:size(board,1)
       for j = 2:size(board,2)
         if board(i,j) ~= iconBlank
         k = j-1;
          while k > 0 && board(i,k) == iconBlank
          board(i,k) = board(i,j);
          board(i,j) = iconBlank;
          j = k;
          k = k-1;
                    end
                end
            end
        end
    case 'down'
        for i = 1:size(board,1)
            for j = size(board,2):-1:1
                if board(i,j) ~= iconBlank
                    k = j+1;
                    while k <= size(board,2) && board(i,k) == iconBlank
                        board(i,k) = board(i,j);
                        board(i,j) = iconBlank;
                        j = k;
                        k = k+1;
                    end
                end
            end
        end
    case 'right'
        for i = 1:size(board,1)
            for j = size(board,2):-1:1
                if board(i,j) ~= iconBlank
                    k = j+1;
                    while k <= size(board,2) && board(i,k) == iconBlank
                        board(i,k) = board(i,j);
                        board(i,j) = iconBlank;
                        j = k;
                        k = k+1;
                    end
                end
            end
        end
end

end

function board = mergeTiles(board, direction)
    case 'up'

    case 'left'

    case 'down'

    case 'right'
end



function keyPressCallback(src, event)
    switch event.Key
        case 'w'
            board = shiftTiles(board,'up')
            board = mergeTiles(board,'up')
        case 'a'
            board = shiftTiles(board,'left')
            board = mergeTiles(board,'left')
        case 's'
            board = shiftTiles(board,'down')
            board = mergeTiles(board,'down')
        case 'd'
            board = shiftTiles(board,'right')
            board = mergeTiles(board,'right')
    end
end



function [newBoard, updatedNumEmptyTiles] = addNewTile(board)
    icon2 = 1;
    iconBlank = 12;
    emptyTiles = find(board == iconBlank);
    if isempty(emptyTiles)
        newBoard = board;
        updatedNumEmptyTiles = 0; % No empty tiles
        return;-
    end
    randomTile = emptyTiles(randi(length(emptyTiles)));
    board(randomTile) = icon2;
    newBoard = board;
    updatedNumEmptyTiles =  prod(size((emptyTiles)))  - 1; % Subtract one for the tile just filled
end

