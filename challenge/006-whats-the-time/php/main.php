<?php

if(!isset($argv) || !isset($argv[1])){
	echo "Usage: php main.php \"<bitmapString>\"";
	exit(1);
}

function getDecimal($decimal){
	return bindec(strrev($decimal));
}

# Preprocess string; remove space columns between certain characters, to make the
# character width uniform
function preprocessBitmap($bitmapCharacterArray, $characterHeight, $removeEveryN){
	$lineWidth = count($bitmapCharacterArray) / $characterHeight;
	foreach($removeEveryN as $removeN){
		for($row = 0; $row < $characterHeight; $row++){
			unset($bitmapCharacterArray[($row * $lineWidth) + $removeN]);
		}
	}
	# Reset index on array
	return array_values($bitmapCharacterArray);
}

$characterEncodings = array(
	getDecimal("010110010010111") => "1",
	getDecimal("111001111100111") => "2",
	getDecimal("111001111001111") => "3",
	getDecimal("101101111001001") => "4",
	getDecimal("111100111001111") => "5",
	getDecimal("100100111101111") => "6",
	getDecimal("111001001001001") => "7",
	getDecimal("111101111101111") => "8",
	getDecimal("111101111001001") => "9",
	getDecimal("111101101101111") => "0",
	getDecimal("000010000010000") => ":"
);

$characterHeight = 5;
$removeEveryN = array(3,13);
$bitmapCharacterArray = preprocessBitmap(str_split($argv[1]), $characterHeight, $removeEveryN);
$characterCount = 5;
$characterWidth = (count($bitmapCharacterArray) / $characterHeight) / $characterCount;

# Prepopulate characters
$characters = array();
for($index = 0; $index < $characterCount; $index++){
	$characters[$index] = 0;
}

# Go through each part of the bitmap array and increment the binary totals
# representing each bitmap character
for($bitmapCharacterArrayIndex = 0; $bitmapCharacterArrayIndex < count($bitmapCharacterArray); $bitmapCharacterArrayIndex++){
	$characterIndex = intdiv($bitmapCharacterArrayIndex, $characterWidth) % $characterCount;
	$column = ($bitmapCharacterArrayIndex % $characterWidth);
	$row = intdiv($bitmapCharacterArrayIndex, $characterCount * $characterWidth);
	$characters[$characterIndex] += pow(2,($row * $characterWidth) + $column) * intval($bitmapCharacterArray[$bitmapCharacterArrayIndex]);
}

# Map decimal value representation to real character
foreach($characters as $character){
	echo isset($characterEncodings[$character]) ? $characterEncodings[$character] : "?";
}
