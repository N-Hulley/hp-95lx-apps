program Guess;

var
  secret, guess, guesses: integer;
  play_again: char;

begin
  repeat
    secret := 50;
    guesses := 0;
    
    WriteLn('===================');
    WriteLn;
    WriteLn('Guess the number');
    WriteLn;
    WriteLn('===================');
    repeat
      guesses := guesses + 1;
      Write('Guess #', guesses, ': ');
      ReadLn(guess);
      
      if (guess < 1) or (guess > 1000) then
      begin
        WriteLn('Must be between 1-1000.');
        WriteLn;
      end
      else if guess = secret then
      begin
        WriteLn('You got it in ', guesses, ' guesses!');
        WriteLn;
      end
      else if guess < secret then
      begin
        WriteLn('Too low');
        WriteLn;
      end
      else
      begin
        WriteLn('Too high');
        WriteLn;
      end;
    until guess = secret;
    
    Write('Play again? (Y/N): ');
    ReadLn(play_again);
    WriteLn;
    
  until (play_again <> 'Y') and (play_again <> 'y');
end.