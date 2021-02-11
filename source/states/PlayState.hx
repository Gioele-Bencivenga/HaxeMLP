package states;

import haxe.ui.containers.ListView;
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

	/**
	 * Array of our lists displaying layers.
	 */
	var layerLists:Array<ListView>;

	/**
	 * Array of our lists displaying weights.
	 */
	var weightsLists:Array<ListView>;

	override function create() {
		/// UI STUFF
		Toolkit.init();
		Toolkit.scale = 1; // temporary fix for scaling while ian fixes it

		setupCameras();

		uiView = ComponentMacros.buildComponent("assets/ui/main-view.xml");
		uiView.cameras = [uiCam]; // all of the ui components contained in uiView will be rendered by uiCam
		uiView.scrollFactor.set(0, 0); // and they won't scroll
		add(uiView);
		// get the generated component and assign it to our function (xml events are for slower scripting with hscript)
		uiView.findComponent("btn_init_perceptron", MenuItem).onClick = btn_initPerceptron_onClick;
		uiView.findComponent("link_website", MenuItem).onClick = link_website_onClick;
		uiView.findComponent("link_github", MenuItem).onClick = link_github_onClick;
		// set the label to reflect the game version defined in Project.xml
		uiView.findComponent("lbl_version", Label).text = haxe.macro.Compiler.getDefine("GAME_VERSION");
		// get a reference to our layer lists
		layerLists = [for (i in 0...2) new ListView()];
		layerLists[0] = uiView.findComponent("lst_input_layer", ListView); // input layer list
		layerLists[1] = uiView.findComponent("lst_hidden_layer", ListView); // hidden layer list
		layerLists[2] = uiView.findComponent("lst_output_layer", ListView); // output layer list
		// get a reference to our weights lists
		weightsLists = [for (i in 0...1) new ListView()];
		weightsLists[0] = uiView.findComponent("lst_inpToHid_weights", ListView); // input to hidden weights list
		weightsLists[1] = uiView.findComponent("lst_hidToOut_weights", ListView); // hidden to output weights list
	}

	function btn_initPerceptron_onClick(_) {
		perc = new Perceptron(5, 3);

		// clear all lists of previous values
		for (list in layerLists) {
			list.dataSource.clear();
		}
		for (list in weightsLists) {
			list.dataSource.clear();
		}

		// fill layer lists
		for (neuron in perc.inputLayer) {
			layerLists[0].dataSource.add(neuron);
		}

		for (neuron in perc.hiddenLayer) {
			layerLists[1].dataSource.add(neuron);
		}

		for (neuron in perc.outputLayer) {
			layerLists[2].dataSource.add(neuron);
		}
		// fill weights list
		var inputToHiddenConns = perc.inputLayer.length * perc.hiddenLayer.length;
		for (i in 0...inputToHiddenConns) {
			weightsLists[0].dataSource.add(perc.weights[i]);
		}
		var hiddenToInputConns = perc.hiddenLayer.length * perc.outputLayer.length;
		for (i in inputToHiddenConns...inputToHiddenConns + hiddenToInputConns) {
			weightsLists[1].dataSource.add(perc.weights[i]);
		}
	}

	function link_website_onClick(_) {
		FlxG.openURL("https://gioele-bencivenga.github.io", "_blank");
	}

	function link_github_onClick(_) {
		FlxG.openURL("https://github.com/Gioele-Bencivenga/HaxeMLP", "_blank");
	}

	function setupCameras() {
		simCam = new FlxZoomCamera(0, 0, FlxG.width, FlxG.height); // create the simulation camera
		simCam.zoomSpeed = 4;
		simCam.bgColor = FlxColor.fromString("#362e28");

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
