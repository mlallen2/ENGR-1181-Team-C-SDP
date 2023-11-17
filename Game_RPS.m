clc
clear

rock = 1;
paper = 2;
scissors = 3;

while true
    Name1 = input('Enter Player1''s name', 's'); 
    Name2 = input('Enter Player2''s name','s'); 

% Player 1
% Print current player and give instructions
    fprintf('%s, choose your iteam.\n',Name1);

% input 
    Player1_item = input('Enter rock, paper, or scissors  ');



% Player 2
    fprintf('%s, choose your item.\n',Name2)

% input 
    Player2_item = input('Enter rock, paper, or scissors  ');

    result = RPS_Function(Player1_item, Player2_item)


    if result == 1 
        msgbox('Player 1 Wins!', Name1)
    elseif result == 2
        msgbox('Player 2 Wins!', Name2)
    elseif result == 3 
        msgbox('Tie')
    end

    yes = 0;
    no = 1;

    disp('Do you want to play Again?')
    playAgain = input('Type yes to continue, no to stop','s');
    
  
    if strcmpi(playAgain, 'yes')
        continue;
    else
        disp('\nbye')
        break;
    end
end
