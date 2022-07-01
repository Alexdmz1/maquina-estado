//implementation of FSM
switch (mState)
{
	case PLAYER_STATES.IDLE:
	{
		if (mInnerState == 0) //enter
		{
			mInnerState = 1;
			sprite_index = s_PlayerIdle;
			mVelX = 0;
		}
		if (mInnerState == 1) //update
		{
			var hMove = -keyboard_check(vk_left) + keyboard_check(vk_right);
			
			if (!IsOnGround())
				ChangeState(PLAYER_STATES.FALL);
			else if (keyboard_check_pressed(vk_up))
				ChangeState(PLAYER_STATES.JUMP);
			else if (abs(hMove) > 0)
				ChangeState(PLAYER_STATES.RUN);
		}
		if (mInnerState == 2) //exit
		{
			mState = mNextState;
			mInnerState = 0;
		}
	}
	break;
	case PLAYER_STATES.RUN:
	{
		if (mInnerState == 0) //enter
		{
			mInnerState = 1;
			sprite_index = s_PlayerRun;
		}
		if (mInnerState == 1) //update
		{
			var hMove = -keyboard_check(vk_left) + keyboard_check(vk_right);
			mVelX = hMove * cSpeed;
			if (hMove != 0)
				image_xscale = sign(hMove);
				
			if (!IsOnGround())
				ChangeState(PLAYER_STATES.FALL);
			else if (keyboard_check_pressed(vk_up))
				ChangeState(PLAYER_STATES.JUMP);
			else if (hMove == 0)
				ChangeState(PLAYER_STATES.IDLE);
		}
		if (mInnerState == 2) //exit
		{
			mState = mNextState;
			mInnerState = 0;
		}
	}
	break;
	case PLAYER_STATES.JUMP:
	{
		if (mInnerState == 0) //enter
		{
			mInnerState = 1;
			sprite_index = s_PlayerJump;
			mVelY = cJumpStrength;
			audio_play_sound(snd_Jump, 500, false);
		}
		if (mInnerState == 1) //update
		{
			var hMove = -keyboard_check(vk_left) + keyboard_check(vk_right);
			mVelX = hMove * cSpeed;
			if (hMove != 0)
				image_xscale = sign(hMove);
				
			if (mVelY >= 0)
				ChangeState(PLAYER_STATES.FALL);
		}
		if (mInnerState == 2) //exit
		{
			mState = mNextState;
			mInnerState = 0;
		}
	}
	break;
	case PLAYER_STATES.FALL:
	{
		if (mInnerState == 0) //enter
		{
			mInnerState = 1;
			sprite_index = s_PlayerFall;
			image_index = 0;
		}
		if (mInnerState == 1) //update
		{
			var hMove = -keyboard_check(vk_left) + keyboard_check(vk_right);
			mVelX = hMove * cSpeed;
			if (hMove != 0)
				image_xscale = sign(hMove);
			
			if (IsOnGround())
				ChangeState(PLAYER_STATES.IDLE);
		}
		if (mInnerState == 2) //exit
		{
			mState = mNextState;
			mInnerState = 0;
		}
	}
	break;
}

UpdateMovement();
