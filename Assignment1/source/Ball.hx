package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Ball extends FlxSprite {

    public var value:Int;
    
    public var PFlask:Flask;

    public function new(x:Float, y:Float, value:Int) {
        super(x, y);
        this.value = value;
        this.PFlask = null;
        
        loadGraphic("assets/images/Number" + value + ".png");
        drag.x = drag.y = 800;
    }

    public function Movement(){
        var Up = FlxG.keys.anyPressed([UP, W]);
        var Down = FlxG.keys.anyPressed([DOWN, S]);
        var Left = FlxG.keys.anyPressed([LEFT, A]);
        var Right = FlxG.keys.anyPressed([RIGHT, D]);

        if(Up){
            velocity.y = -200;
        }

        if(Down){
            velocity.y = 200;
        }

        if(Left){
            velocity.x = -200;
        }

        if(Right){
            velocity.x = 200;
        }
    }

    override public function update(elapsed: Float) {
        super.update(elapsed);
        Movement();
    }
}