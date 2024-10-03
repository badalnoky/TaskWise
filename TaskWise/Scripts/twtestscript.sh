#!/bin/sh

echo "Testing started"
cd ~/Developer/TaskWise/TaskWise
echo "Changed directory.."
xcodebuild -workspace TaskWise.xcworkspace -scheme TaskWise -destination "name=iPhone 16 Pro" -destination "name=iPad Pro 13-inch (M4)" test
echo "Finished testing, attempting to open results."
open /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test/"$(ls /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test | tail -n 1)"
