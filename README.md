# MathMatchGame
A simple math match game in MIPS Assembly

MATH MATCH GAME
USER MANUAL

How To Setup the MIPS Environment
1.	Download MARS Assembler ver. 4.5 (do not use Mars_Plus since its I/O area has different line spacing and will affect gameplay) - https://dpetersanderson.github.io/
2.	The assembler also requires JAVA J2SE (1.5 or later) SDK which can be installed here - https://www.oracle.com/java/technologies/downloads/?er=221886
3.	Then, locate the Mars4_5.jar file, right click -> Open with ->  Java Platform SE Library, which was installed in previous step
4.	Go to Settings on and make sure to check these selections
 - Assemble all files in Directory
 - Initialize Program Counter to global 'main' if defined
5.	Make sure all game files are kept in the same folder and not moved outside
6.	Follow these steps then – File -> Open… -> PROJECT MULTIPLY (locate this folder inside the same folder along with this user manual) -> runGame.asm 
7.	Go to Run -> Assemble. You will see the “Mars Messages” updated with some text confirming the program has been compiled successfully.
8.	Click on the small upward-facing arrow just above the “Mars Messages” tab to expand the area
9.	Click on the “Run I/O” tab just beside “Mars Messages” tab
10.	Clear the area before every game run for best experience
11.	You are now ready to play the game. 
12.	To start, go to Run -> Go

Game Rules and How To Play
a.	What is the game
o	Imagine a card with 2 sides. One side of the card is written with a number (such as 8) or a mathematical multiplication expression (such as 4 x 2)
o	Imagine such 16 cards (guaranteed at least every pair will have the same product) with their ‘?’ side facing up. Shuffle them all and put them on a surface in a 4 x 4 matrix.
o	Every turn, you are allowed to flip 2 of the 16 cards with ‘?’ facing up and see their value
o	Your goal is to match 2 cards which amount to the same value (such as 5x5 and 25)
o	If you select 2 cards with different values, you will have to flip them back so that ‘?’ is facing up again
o	If you select 2 cards with same values, those 2 cards will remain in same place
o	You repeat these turns until you have all cards with their values facing up (or all ‘?’ facing down)
o	This is when the game is finished, and you have won!
Hint: Try to remember the location and value of first 3-4 cards you have flipped so that you have a higher chance of flipping 2 same cards when you flip the next cards

b.	How to play this game in MARS Assembler 
(All warnings and points of failure are bolded and in uppercase)
o	Complete all the steps in “How to setup the MIPS environment”
o	Once you start the game, it will tell you all the basic rules. I will still write the rules in more detail here
o	To start the game, press ‘y’ on your keyboard (BE CAREFUL of the lowercase)
o	If you do not press ‘y’, the game will end
o	You will be greeted with a “LETS BEGIN” message followed by the card matrix/table popping up slowly
o	You will be prompted to enter column and row of the card you wish to select at the bottom of I/O area
o	DO NOT write anything in the console before getting the prompt
o	The cards are named after their column and row 
o	BE CAREFUL and only enter in lowercase
o	BE CAREFUL when entering column, since MIPS does now allow to go back after entering a single character (byte)
o	DO NOT go beyond the range (a-d and 0-3) when selecting cards since that will result in unexpected results/errors
o	Press “Enter” on your keyboard after making selection
o	Keep on selecting 2 cards per turn and try to match them
o	After selecting 2 cards, wait 1-2 seconds for the sound effect to play and for the program to give you another prompt
o	DO NOT try to write anything to the console before the tone ends as that will result in program termination with errors (if this happens, clear the Run I/O area and repeat steps 7 – 12 to restart the game with different cards)
o	After you have won the game (flipped all the cards to show their value), you will be congratulated with a message and a super mario tone will play. CONGRATULATIONS!
o	If you wish to play the game again, repeat steps 7 – 12.
