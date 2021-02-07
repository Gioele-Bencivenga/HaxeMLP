package states;

import utilities.HxFuncs;
import utilities.FlxFuncs;
import flixel.math.FlxMath;
import flixel.addons.display.FlxZoomCamera;
import haxe.ui.containers.menus.MenuItem;
import haxe.ui.core.Component;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.components.*;
import haxe.ui.Toolkit;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject.*;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import echo.util.TileMap;
import brains.*;

using flixel.util.FlxArrayUtil;
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState {
	/**
	 * Simulation camera, the camera displaying the simulation.
	 */
	var simCam:FlxZoomCamera;

	/**
	 * UI camera, the camera displaying the interface indipendently from zoom.
	 */
	var uiCam:FlxCamera;

	/**
	 * Our UI using haxeui, this contains the list of components and all.
	 */
	var uiView:Component;

	var perc:Perceptron;

	override function create() {
		/// UI STUFF
		Toolkit.init();
		Toolkit.scale = 1; // temporary fix for scaling while ian fixes it

		setupCameras();

		uiView = ComponentMacros.buildComponent("assets/ui/main-view.xml");
		uiView.cameras = [uiCam]; // all of the ui components contained in uiView will be rendered by uiCam
		uiView.scrollFactor.set(0, 0); // and they won't scroll
		add(uiView);
		// xml events are for scripting with hscript, so we need to get the generated component from code and assign it to the function
		uiView.findComponent("btn_init_perceptron", MenuItem).onClick = btn_initPerceptron_onClick;
		uiView.findComponent("link_website", MenuItem).onClick = link_website_onClick;
		uiView.findComponent("link_github", MenuItem).onClick = link_github_onClick;
		uiView.findComponent("lbl_version", Label).text = haxe.macro.Compiler.getDefine("GAME_VERSION");
	}

	function btn_initPerceptron_onClick(_){

	}

	function link_website_onClick(_) {
		FlxG.openURL("https://gioele-bencivenga.github.io", "_blank");
	}

	function link_github_onClick(_) {
		FlxG.openURL("https://github.com/Gioele-Bencivenga/TilemapGen", "_blank");
	}

	function setupCameras() {
		simCam = new FlxZoomCamera(0, 0, FlxG.width, FlxG.height); // create the simulation camera
		simCam.zoomSpeed = 4;
		simCam.bgColor = FlxColor.BLACK; // empty space will be rendered as black

		FlxG.cameras.reset(simCam); // dump all current cameras and set the simulation camera as the main one
		// FlxCamera.defaultCameras = [simCam]; // strange stuff seems to happen with this

		uiCam = new FlxCamera(0, 0, FlxG.width, FlxG.height); // create the ui camera
		uiCam.bgColor = FlxColor.TRANSPARENT; // transparent so we see what's behind it
		FlxG.cameras.add(uiCam); // add it to the cameras list (simCam doesn't need because we set it as the main already)
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
