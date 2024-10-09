package;

import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;

class MenuState extends FlxState
{
    var PlayButton: FlxButton; 
	override public function create()
	{
        bgColor = FlxColor.WHITE;
        var Title = new flixel.text.FlxText(100, 100, 0, "Welcome to Havan's Game, \n Please Click 'Start' button.", 24, true);
        Title.setFormat(24, FlxColor.BLACK);
        add(Title);
        PlayButton = new FlxButton(0, 0, "Start", clickPlay);
        add(PlayButton);
        PlayButton.screenCenter();

        var Info = new flixel.text.FlxText(100, 300, 0, "Havan's is a puzzle game where you drop numbered balls into flasks and merge them to score bigger. \n
        Go through 5 levels, mix and match those balls, \n
        and watch those numbers grow as you aim for victory. \n
        Get ready to merge and master in a flask of fun!\n
        Credit: https://www.crazygames.com/game/2048-in-flasks");
        Info.setFormat(12, FlxColor.BLACK);

        add(Info);
		super.create();
	}

    function clickPlay()
        {
            FlxG.switchState(new PlayState());
        }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}