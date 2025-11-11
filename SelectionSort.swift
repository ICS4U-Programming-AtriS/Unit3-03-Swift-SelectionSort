//
//  SelectionSort.swift
//
//  Created by Atri Sarker
//  Created on 2025-Month-Day
//  Version 1.0
//  Copyright (c) 2025 Atri Sarker. All rights reserved.
//
//  Selection Sort.
import Foundation

// Constant for the file path of the input file.
let inputFilePath = "./input.txt"
// Constant for the file path of the output file.
let outputFilePath = "./output.txt"

// Selection Sort Function
// Sorts an array of integers using the selection sort algorithm.
func selectionSort(_ array: [Int]) -> [Int] {
    var arr = array
    // Get the array's size
    let arrSize = arr.count
    // Get the bound for iteration
    let iterationstop = arrSize - 1
    // Iterate over the bound
    for threshold in 0 ..< iterationstop {
        // Get the smallest number
        // that resides in the unsorted partition
        // Start at the beginning of the unsorted partition.
        var minNumIndex = threshold
        // Set the first unsorted element as the minimum
        var minNum = arr[minNumIndex]
        // Backtrack over the sorted partition
        // Go through the unsorted partition and get the smallest number.
        for index in (threshold + 1) ..< arrSize {
            // Get the number found at the index
            let num = arr[index]
            // Check if it is smaller
            if num < minNum {
                // If so, make it the new smallest number
                minNum = num
                minNumIndex = index
            }
        }
        // Perform the swap
        let temp = arr[threshold]
        arr[threshold] = minNum
        arr[minNumIndex] = temp
    }
    // Return the sorted array
    return arr
}

// Access the input file
guard let inputFile = FileHandle(forReadingAtPath: inputFilePath) else {
    print("CANNOT OPEN INPUT FILE")
    exit(1)
}

// Access the output file for writing
guard let outputFile = FileHandle(forWritingAtPath: outputFilePath) else {
    print("CANNOT OPEN OUTPUT FILE FOR WRITING")
    exit(1)
}

// Helper function for writing data
func writeToOutputFile(_ text: String) {
    if let data = text.data(using: .utf8) {
        outputFile.write(data)
    } else {
        print("Error: WRITING FAILED")
    }
}

// Read the contents of the input file
let inputData = inputFile.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("CANNOT CONVERT FILE DATA TO A STRING")
    exit(1)
}

// Create a list of all available lines
let listOfLines = inputString.components(separatedBy: .newlines)

// Loop through all the lines in the list
for line in listOfLines {
    // Check if the line is empty
    if line == "" {
        // If so, write an error message and continue
        writeToOutputFile("Error: No integers were found on this line.\n")
        continue
    }
    // Split the line
    let stringArr = line.split(separator: " ")
    // Convert String array into an int array
    var intArr = [Int]()
    for str in stringArr {
        if let num = Int(str) {
            intArr.append(num)
        }
    }
    // Print Array before Sorting
    print("Before: \(intArr)")
    // Sort the array
    let sortedArr = selectionSort(intArr)
    // Print Array after Sorting
    print("After: \(sortedArr)")

    // Write the sorted array to the output file
    for num in sortedArr {
        writeToOutputFile("\(num) ")
    }
    // Write a newline
    writeToOutputFile("\n")
}
