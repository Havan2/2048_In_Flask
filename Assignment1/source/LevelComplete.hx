package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class LevelComplete extends FlxGroup {
    private var NextLevel:FlxButton;
    private var BakGround:FlxSprite;
    private var Message:FlxText;

    public function new(onNextLevel:Void->Void) {
        super();

        BakGround = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        BakGround.alpha = 0.5;
        add(BakGround);

        Message = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Hooray! 🥳\nClick 'Next level' for Next Level!");
        Message.setFormat(null, 24, FlxColor.BLACK, "center");
        add(Message);

        NextLevel = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 10, "Next Level", onNextLevel);
        add(NextLevel);
    }

    public static function ifWin(flasks:Array<Flask>, targetValue:Int, playState:PlayState):Void {
        for (flask in flasks) {
            for (ball in flask.ArrBalls) {
                if (ball.value == targetValue) {
                    trace("You have reached the Goal!");

                    playState.WinState = new LevelComplete(function() {
                        playState.remove(playState.WinState, true);
                        playState.WinState = null;
                        playState.UpdateLevel();
                    });
                    playState.add(playState.WinState);
                    return;
                }
            }
        }
    }
}
