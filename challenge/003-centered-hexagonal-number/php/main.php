<?php

if(!isset($argv) || !isset($argv[1])){
	echo "Usage: php main.php n";
	exit(1);
}

$x = intval($argv[1]);

// If valid, the following must hold true,
// where n and x are positive integers
# 3n^2 + 3n + 1 = $x
$n = null;

function isValidSolution($solution){
   return is_numeric($solution) 
	&& floor($solution) == $solution
	&& $solution >= 0;
}

$a = $b = 3;
$c = 1-$x;

// Solve quadratic
if (       isValidSolution($solution = (-$b + sqrt(pow($b,2) - 4*$a*$c)) / (2*$a))
	|| isValidSolution($solution = (-$b - sqrt(pow($b,2) - 4*$a*$c)) / (2*$a)) ){
	$n = $solution;
}

function printLine($lineWidth, $circleCount){
	$string = "";
	for($i = 0; $i < $circleCount; $i++){
		$string .= " 0 ";
	}
	$buffer = (($lineWidth - strlen($string)) / 2) + 1;
	return sprintf("%".$buffer."s%s\n\n", " ", $string);
}

if($n === null){
	echo "Invalid\n";
} else {
	$maxCirclesInRow = ($n * 2) + 1;
	$lineWidth = $maxCirclesInRow * 3; // " O " - 3 chars to represent circle
	for ($i = 0; $i < $n; $i++){
		$circlesInRow = $maxCirclesInRow + ($i - $n);
		echo printLine($lineWidth, $circlesInRow);
	}
	for ($i = $n; $i >= 0; $i--){
		$circlesInRow = $maxCirclesInRow + ($i - $n);
		echo printLine($lineWidth, $circlesInRow);
	}
	echo "\n";
}
