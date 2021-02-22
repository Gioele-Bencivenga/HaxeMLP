package brains;

import flixel.FlxG;
import Math;

/**
 * MultiLayer Perceptron.
 * 
 * next steps:
 * do weighted sum for each neuron then pass through activation function
 * (more computationally efficient if you do sum+tanh for each single neuron instead of doing all the sums then passing all of the sums throught tanh at once) 
 * 
 * for activation function:
 * tanh (hyperbolic function), found in standard Math library
 */
class Perceptron {
	/**
	 * The Perceptron's input layer.
	 *
	 * Specify the number of neurons when creating a new instance, each neuron's values is randomly assigned.
	 */
	public var inputLayer(default, null):Array<Float>;

	/**
	 * The perceptron's hidden layer.
	 */
	public var hiddenLayer(default, null):Array<Float>;

	/**
	 * The perceptron's hidden layer.
	 */
	public var outputLayer(default, null):Array<Float>;

	/**
	 * Array of weights for the connections between neurons.
	 */
	public var weights(default, null):Array<Float>;

	/**
	 * Total number of connection weights.
	 *
	 * Calculated by doing the sum between:
	 * - number of weights between input and hidden layers: `input neurons * hidden neurons`
	 * - number of weights between hidden and output layers: `hidden neurons * output neurons`
	 */
	var weightsCount:Int;

	/**
	 * The rate at which the `Perceptron` learns.
	 */
	public var learningRate(default, null):Float;

	/**
	 * Creates a new `Perceptron` instance and initializes each neuron to random values between -1 and 1 inclusive.
	 * @param _inputLayerSize the number of neurons that the `inputLayer` will have
	 * @param learningRate `0.01` by default, it's the `Perceptron`'s learning rate
	 */
	public function new(_inputLayerSize:Int, _hiddenLayerSize:Int, _learningRate = 0.01) {
		learningRate = _learningRate;

		// initialise layers with neurons having random values
		inputLayer = [for (i in 0..._inputLayerSize) FlxG.random.float(-1, 1)];
		hiddenLayer = [for (i in 0..._hiddenLayerSize) FlxG.random.float(-1, 1)];
		outputLayer = [for (i in 0...1) FlxG.random.float(-1, 1)];

		// calculate number of connection weights between neurons and initialise them with random values
		weightsCount = (inputLayer.length * hiddenLayer.length) + (hiddenLayer.length * outputLayer.length);
		weights = [for (i in 0...weightsCount) FlxG.random.float(-1, 1)];
	}

	/**
	 * Feed the input forward through the network.
	 * 
	 * Each neuron calculates the weighted sum of 
	 * @param _inputs the array of input inputLayer the Perceptron receives
	 * @return the summed vector
	 */
	public function feedForward(_inputs:Array<Float>):Float {

		for(neuron in hiddenLayer){
			var sum:Float = 0;
			for(inputNeuron in inputLayer){
				//sum += inputNeuron * weight
				// take a piece or paper and go over the process with it
				// watch recording of james 
			}

		}
		return 0;
	}

	/*
		public function train(_input:Vector2, _error:Vector2) {
			// Adjust all the inputLayer according to the error and learning rate
			inputLayer[0] += learningRate * _error.x * _input.x;
			inputLayer[0] += learningRate * _error.y * _input.y;
			inputLayer[0] = HxFuncs.constrain(inputLayer[0], 0, 1);
		}
	 */
}
