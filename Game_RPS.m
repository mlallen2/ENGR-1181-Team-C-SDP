clc
clear

%Variables
rock = 1;
Rock = 1;
paper = 2;
Paper = 2;
scissors = 3;
Scissors = 3;

%Sets inital scene
rps_scene = simpleGameEngine('RPS_image.png',84,84,6,[72,60,50]);

while true
drawScene(rps_scene, [7, 7, 7, 7, 7, 7, 7; 8, 8, 8, 8, 8, 8, 8; 8, 4, 8, 8, 8, 5, 8; 8, 8, 8, 6, 8, 8, 8; 8, 8, 8, 8, 8, 8, 8;7, 7, 7, 7, 7, 7, 7])
title('Rock Paper Scissors', 'FontSize',30)

pause(1)

% Assigns names to players
txt_instructions = 'Enter Player 1''s name';
obj1 = text(1750,2300,txt_instructions, 'fontsize',17,'Color','w','HorizontalAlignment', 'center'); 

Name1 = input('Enter Player 1''s name', 's');
txt_player1name = Name1;
obj2 = text(750,900,txt_player1name, 'fontsize',22,'Color','w' ,'HorizontalAlignment', 'center');

delete(obj1);

txt_instructions = 'Enter Player 2''s name';
obj1 =  text(1750,2300,txt_instructions, 'fontsize',17,'Color','w','HorizontalAlignment', 'center');

Name2 = input('Enter Player2''s name', 's');
txt_player2name = Name2;
obj3 = text(2750,900,txt_player2name, 'fontsize',22,'Color','w','HorizontalAlignment', 'center');

delete(obj1);

% Assigins players their objects
txt_instructions = [ Name1 , ' type your item: rock, paper, or scissors'];
obj1 =  text(1750,2300,txt_instructions, 'fontsize',14,'Color','w','HorizontalAlignment', 'center');

Player1_item = input('Enter rock, paper, or scissors  ');

delete(obj1);

txt_instructions = [ Name2 , ' type your item: \n rock, paper, or scissors'];
obj1 = text(1750,2300,txt_instructions, 'fontsize',14,'Color','w','HorizontalAlignment', 'center');

Player2_item = input('Enter rock, paper, or scissors  ');

delete(obj1);

drawScene(rps_scene, [7, 7, 7, 7, 7, 7, 7;8, 8, 8, 8, 8, 8, 8; 8, 4, 8, 8, 8, 5, 8; 8, Player1_item, 8, 6, 8, Player2_item, 8; 8, 8, 8, 8, 8, 8, 8; 7, 7, 7, 7, 7, 7, 7])

% Determines the reults of the game
 result = RPS_Function(Player1_item, Player2_item);

    if result == 1 
        txt_instructions = [ Name1 , ' you won!!'];
        obj1 = text(1750,2300,txt_instructions, 'fontsize',20,'Color','w','HorizontalAlignment', 'center');
    elseif result == 2
        txt_instructions = [ Name2 , ' you won!!'];
        obj1 = text(1750,2300,txt_instructions, 'fontsize',20,'Color','w','HorizontalAlignment', 'center');
    elseif result == 3 
        txt_instructions =  'Its a tie';
        obj1 = text(1750,2300,txt_instructions, 'fontsize',20,'Color','w','HorizontalAlignment', 'center');
    end

% Asks if they would like to play again   
pause(2.25);

delete(obj1);

txt_instructions = ('Type yes to continue, no to stop');
obj1 = text(1750,2300,txt_instructions, 'fontsize',16,'Color','w','HorizontalAlignment', 'center');
playAgain = input('Type yes to continue, no to stop','s');

yes = 0;
no = 1;
    
    
    if strcmpi(playAgain, 'yes')
        delete(obj1)
        delete(obj2)
        delete(obj3)
        continue;
    else
        delete(obj1);
        txt_instructions = ('Thanks for playing!');
        obj1 = text(1750,2300,txt_instructions, 'fontsize',20,'Color','w','HorizontalAlignment', 'center');
        break;
    end
end
