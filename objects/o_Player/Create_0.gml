
mVelX = 0;
mVelY = 0;
cSpeed = 100;
cJumpStrength = -300;
cGravity = 1000;

#region//UpdaetMovement
UpdateMovement = function()
{
	mVelY += cGravity * global.dt;
	
	//collision response based off Shaun Spalding's implementation
	if (place_meeting(x + mVelX * global.dt, y, o_Wall))
	{
		while (!place_meeting(x + sign(mVelX), y, o_Wall))
		{
			x += sign(mVelX);
		}
		mVelX = 0;
	}
	x += mVelX * global.dt;
	
	if (place_meeting(x, y + mVelY * global.dt, o_Wall))
	{
		while (!place_meeting(x, y + sign(mVelY), o_Wall))
		{
			y += sign(mVelY);
		}
		mVelY = 0;
	}
	y += mVelY * global.dt;
}
#endregion

#region//IsOnGround
IsOnGround = function()
{
	return place_meeting(x, y+1, o_Wall);
}
#endregion

#region//FSM
enum PLAYER_STATES
{
	IDLE,
	RUN,
	JUMP,
	FALL
}
#endregion


mState = PLAYER_STATES.IDLE;
mInnerState = 0; //0-enter, 1-update, 2-exit
mNextState = mState;

#region//ChangeState
ChangeState = function(nextState)
{
	mNextState = nextState;
	mInnerState = 2;
}
#endregion