function [result]= RPS_Function(p1,p2) % FUnction to calculate who the winner is

% Tests diffrent inputs of player 2 when player 1 chooses rock
if p1 == 1 
elseif p2 == p1
    result = 3; % results in a tie
elseif p2 == 2
    result = 2;% Player 2 wins
else 
    result = 1;% player 1 wins
end

% Tests diffrent inputs of player 2 when player 1 chooses paper
if p1 == 2 
elseif p2 == p2
    result = 3; % results in a tie
elseif p2 == 1
    result = 1;% player 1 wins
else 
    result = 2;% Player 2 wins
end

% Tests diffrent inputs of player 2 when player 1 chooses scissors
if p1 == 3  
elseif p2 == p1
    result = 3; % results in a tie
elseif p2 == 1
    result = fprintf('Player 1 wins ');
else
    result = 2;% Player 2 wins
end