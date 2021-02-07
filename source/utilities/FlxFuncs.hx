package utilities;

import flixel.group.FlxGroup;

/**
 * A bunch of helper functions for HaxeFlixel that I felt like keeping.
 * 
 * If you notice any mistakes or things that you could do better please tell me!
 */
class FlxFuncs {
    /**
	 * This function `kill()`s, `clear()`s and `revive()`s the passed `FlxGroup`s.
	 *
	 * It's mostly used when re-generating the world.
	 *
	 * I think doing this resets the groups and it helped fix a bug with collision when regenerating the map.
	 *
	 * @param groupsToEmpty an array containing the `FlxGroup`s that you want to reset.
	 */
	public static inline function emptyGroups(groupsToEmpty:Array<FlxGroup>) {
		for (group in groupsToEmpty) {
			group.kill();
			group.clear();
			group.revive();
		}
	}
}
