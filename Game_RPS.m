clc
clear

rock = 1;
paper = 2;
sissors = 3;

while answer == 'yes'
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
        msgbox('Player 1 Wins!')
    elseif result == 2
        msgbox('Player 2 Wins!')
    elseif result == 3 
        msgbox('Tie')
    end

    disp('Do you want to play Again')
    answer = input('Type yes to continue, no to stop')
    
    if answer == 'no'
        disp('Have a nice day')
    end
end