extends Statistic
class_name Enemies_Killed

var CANT_BE_STOPPED = preload("res://Achievements/Achievements/cant_be_stopped.tres")
var I_AM_ELECTRIC = preload("res://Achievements/Achievements/i_am_electric.tres")
var ONE_OF_MANY = preload("res://Achievements/Achievements/one_of_many.tres")
var SERVANT_OF_DEATH = preload("res://Achievements/Achievements/servant_of_death.tres")

@export var enemies_killed: int = 0 :
    set(val):
        enemies_killed += val;
        if enemies_killed >= 1:
            CANT_BE_STOPPED.hasUnlocked = true;
        if enemies_killed >= 100:
            I_AM_ELECTRIC.hasUnlocked = true;
        if enemies_killed >= 1000:
            ONE_OF_MANY.hasUnlocked = true;
        if enemies_killed >= 10000:
            SERVANT_OF_DEATH.hasUnlocked = true;
