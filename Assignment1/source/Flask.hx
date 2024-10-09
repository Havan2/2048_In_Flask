package;

import Ball;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Flask extends FlxSprite {

    public var ArrBalls:Array<Ball>;

    public function new(x:Float, y:Float) {
        super(x, y);
        ArrBalls = [];
        loadGraphic("assets/images/flask.png");
        this.scale.set(1.5,1.5);
    }

    public function PutBall(ball:Ball):Void {
        ArrBalls.push(ball);
        ball.PFlask = this;
        NewBallPoston();
        ChCombine();
    }

    public function TakeBall(ball:Ball):Void {
        ArrBalls.remove(ball);
        ball.PFlask = null;
        NewBallPoston();
    }

    public function ClearFlask():Void {
        ArrBalls = [];
    }

    public function NewBallPoston():Void {
        var baseY = this.y + this.height - 10; 
        var spacing = 32; 
        

        for (i in 0...ArrBalls.length) {
            var ball = ArrBalls[i];
            ball.x = this.x + (this.width - ball.width) / 2; 
            ball.y = baseY - (i + 1) * spacing;
        }
    }

    private function ChCombine():Void {
        
        var ballGroups = new Map<Int, Array<Ball>>();
        for (ball in ArrBalls) {
            
            if (!ballGroups.exists(ball.value)) {
                ballGroups.set(ball.value, []);
            }

            ballGroups.get(ball.value).push(ball);
        }

        for (group in ballGroups) {
            if (group.length >= 2) {
                var playState = cast FlxG.state, PlayState;
                for (oldBall in group) {
                    TakeBall(oldBall);
                    playState.ballsGroup.remove(oldBall, true);
                    oldBall.destroy();
                }

                var newValue = group[0].value * 2;
                var newBall = new Ball(this.x, this.y, newValue);
                playState.ballsGroup.add(newBall);
                PutBall(newBall);

                ChCombine();
                break;
            }
        }
    }
}
