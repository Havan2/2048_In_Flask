package;

import Ball;
import Flask;
import LevelComplete;
import flixel.*;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState {

    public var FlaskArray:Array<Flask>;
    public var LatestBall:Ball;
    public var Target:Int;
    public var TargetText:FlxText;

    public var ballsGroup:FlxTypedGroup<Ball>;
    public var MovedBall:Ball = null;

    public var WinState:LevelComplete; 

    override public function create():Void {
        super.create();

        bgColor = FlxColor.WHITE;

        ballsGroup = new FlxTypedGroup<Ball>();
        add(ballsGroup);

        Target = 8;

        var textWidth = 150;
        TargetText = new FlxText(FlxG.width - textWidth - 10, 10, textWidth, "Goal: " + Target);
        TargetText.setFormat(null, 16, FlxColor.BLACK, "right");
        TargetText.scrollFactor.set(0, 0);
        add(TargetText);


        FlaskArray = [];
        for (i in 0...3) {
            var flaskX = 100 + i * 200; 
            var flaskY = 300;          
            var flask = new Flask(flaskX, flaskY);
            FlaskArray.push(flask);
            add(flask);
        }

        DropNewBall(2);
    }

    public function DropNewBall(value:Int):Void {
        var ballX = (FlxG.width - 84) / 2; 
        var ballY = FlxG.height - 72 ; 
        LatestBall = new Ball(ballX, ballY, value);
        ballsGroup.add(LatestBall);
    }

    public function BalltoFlask(ball:Ball, flask:Flask):Void {
        if (ball.PFlask != null) {
            ball.PFlask.TakeBall(ball);
        }

        flask.PutBall(ball);
    }

    public function DropNextNewBall():Void {
        var values = [2, 4, 8];
        var nextValue = values[FlxG.random.int(0, values.length - 1)];
        DropNewBall(nextValue);
    }

    public function UserInteration():Void {

        var MousePosition = FlxG.mouse.getWorldPosition();

        if (FlxG.mouse.justPressed && MovedBall == null) {
            for (ball in ballsGroup) {

                if (ball != null && ball.overlapsPoint(MousePosition)) {
                    MovedBall = ball;
                    ballsGroup.members.remove(ball);
                    ballsGroup.members.push(ball);
                    break;
                }
            }
        }

        if (MovedBall != null) {

            MovedBall.x = MousePosition.x - MovedBall.width / 2;
            MovedBall.y = MousePosition.y - MovedBall.height / 2;

            if (FlxG.mouse.justReleased) {
                var InFlask:Bool = false;
                for (flask in FlaskArray) {

                    if (MovedBall.overlaps(flask)) {
                        BalltoFlask(MovedBall, flask);
                        InFlask = true;

                        if (MovedBall == LatestBall) {
                            LatestBall = null;
                            DropNextNewBall();
                        }
                        break;
                    }
                }

                if (!InFlask) {
                    
                    if (MovedBall.PFlask != null) {
                        MovedBall.PFlask.NewBallPoston();
                    } 
                    
                    else if (MovedBall == LatestBall) {

                        var ballX = (FlxG.width - MovedBall.width) / 2;
                        var ballY = FlxG.height - MovedBall.height - 20;
                        MovedBall.x = ballX;
                        MovedBall.y = ballY;
                    }
                }

                MovedBall = null;
            }
        }
    }

    public function UpdateLevel():Void {
        
        Target *= 2; 
        trace("New Level! New Goal:" + Target);

        
        TargetText.text = "Goal: " + Target;

    
        for (flask in FlaskArray) {
            for (ball in flask.ArrBalls) {
                ballsGroup.remove(ball, true);
                ball.destroy();
            }
            flask.ClearFlask();
        }

        if (LatestBall != null) {
            ballsGroup.remove(LatestBall, true);
            LatestBall.destroy();
            LatestBall = null;
        }

        if (MovedBall != null) {
            ballsGroup.remove(MovedBall, true);
            MovedBall.destroy();
            MovedBall = null;
        }

        DropNewBall(2);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (WinState == null) {
            UserInteration();
            LevelComplete.ifWin(FlaskArray, Target, this); 
        }
    }
}
