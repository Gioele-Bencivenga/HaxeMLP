package brains;

import utilities.HxFuncs;
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
	 * The perceptron's input layer.
	 */
	public var inputLayer(default, null):Array<Float>;

	/**
	 * The perceptron's hidden layer.
	 */
	public var hiddenLayer(default, null):Array<Float>;

	/**
	 * Array of outputs processed by the hidden layer.
	 */
	public var hiddenOutputs(default, null):Array<Float>;

	/**
	 * The perceptron's hidden layer.
	 */
	public var outputLayer(default, null):Array<Float>;

	/**
	 * Array of outputs processed by the output layer.
	 */
	public var outputOutputs(default, null):Array<Float>;

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
	 * Creates a new `Perceptron` instance and initializes each neuron to random values between -1 and 1 inclusive.
	 * 
	 * All of the `weights` (connections) between neurons are also randomly generated.
	 * 
	 * @param _inputLayerSize the number of neurons that the `inputLayer` will have
	 * @param _hiddenLayerSize the number of neurons that the `hiddenLayer` will have
	 * @param _outputLayerSize the number of neurons that the `outputLayer` will have
	 */
	public function new(_inputLayerSize:Int, _hiddenLayerSize:Int, _outputLayerSize:Int) {
		// initialise layers of neurons
		inputLayer = [for (i in 0..._inputLayerSize) 0]; // not needed anymore?
		hiddenLayer = [for (i in 0..._hiddenLayerSize) FlxG.random.float(-1, 1)];
		outputLayer = [for (i in 0..._outputLayerSize) FlxG.random.float(-1, 1)];
		// initialise lists of outputs with 0s
		hiddenOutputs = [for (i in 0..._hiddenLayerSize) 0];
		outputOutputs = [for (i in 0..._outputLayerSize) 0];

		// calculate number of connection weights between neurons and initialise them with random values
		weightsCount = (inputLayer.length * hiddenLayer.length) + (hiddenLayer.length * outputLayer.length);
		weights = [for (i in 0...weightsCount) FlxG.random.float(-1, 1)];
	}

	/**
	 * Feed the input forward through the network.
	 * 
	 * Optimize with matrix multiplication in the future if needed.
	 * 
	 * @param _inputLayer the input data that the network will process, values must be between -1 and 1
	 * @return the array of outputs produced by the network, each output ranging from -1 to 1 inclusive
	 */
	public function feedForward(_inputLayer:Array<Float>):Array<Float> {
		var wc:Int = 0; // weights counter

		for (i in 0...hiddenLayer.length) {
			var sum:Float = 0;
			for (j in 0..._inputLayer.length) {
				sum += _inputLayer[j] * weights[wc++];
			}
			hiddenOutputs[i] = HxFuncs.tanh(sum);
		}

		for (i in 0...outputLayer.length) {
			var sum:Float = 0;
			for (j in 0...hiddenOutputs.length) {
				sum += hiddenOutputs[j] * weights[wc++];
			}
			outputOutputs[i] = HxFuncs.tanh(sum);
		}

		return outputOutputs;
	}
}
