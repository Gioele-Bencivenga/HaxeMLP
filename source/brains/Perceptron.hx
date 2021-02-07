package brains;

import utilities.HxFuncs;
import hxmath.math.Vector2;
import flixel.FlxG;

/**
 * Single Layer Perceptron.
 */
class Perceptron {
	/**
	 * The Perceptron's input layer.
	 *
	 * Specify the number of neurons when creating a new instance, each neuron's values is randomly assigned.
	 */
	public var inputLayer(default, null):Array<Float>;

	/**
	 * The rate at which the `Perceptron` learns.
	 */
	public var learningRate(default, null):Float;

	/**
	 * Creates a new `Perceptron` instance and initializes each neuron to random values between -1 and 1 inclusive.
	 * @param _inputLayerSize the number of neurons that the `inputLayer` will have
	 * @param learningRate `0.01` by default, it's the `Perceptron`'s learning rate
	 */
	public function new(_inputLayerSize:Int, _learningRate = 0.01) {
		learningRate = _learningRate;

		// each weight is given a random value between -1 and 1
		inputLayer = [for (i in 0..._inputLayerSize) FlxG.random.float(-1, 1)];
	}

	/**
	 * This function takes in an array of Vector2 and calculates something.
	 * @param _inputs the array of input inputLayer the Perceptron receives
	 * @return the summed vector
	 */
	public function feedForward(_input:Vector2):Vector2 {
		var sum = new Vector2(0, 0);

		for (i in 0...inputLayer.length) {
			_input.multiplyWith(inputLayer[i]);
			sum.addWith(_input);
		}
		return sum;
	}

	public function train(_input:Vector2, _error:Vector2) {
		// Adjust all the inputLayer according to the error and learning rate
		inputLayer[0] += learningRate * _error.x * _input.x;
		inputLayer[0] += learningRate * _error.y * _input.y;
		inputLayer[0] = HxFuncs.constrain(inputLayer[0], 0, 1);
	}
}
