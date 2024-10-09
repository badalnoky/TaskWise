#!/bin/sh
echo "Setting environment"
rm -f ~/Library/Group\ Containers/2D3N9A382G.group.me.bercidalnoky.TaskWiseMac/TaskWise.sqlite
cd ~/Developer/TaskWise/TaskWise

echo "Starting iOS tests"
xcodebuild -workspace TaskWise.xcworkspace -scheme TaskWise -destination "name=iPhone 16 Pro" -destination "name=iPad Pro 13-inch (M4)" test

echo "Finished testing on iOS, showing results"
open /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test/"$(ls /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test | tail -n 1)"

echo "Starting macOS tests"
xcodebuild -workspace TaskWise.xcworkspace -scheme TaskWiseMac -destination "name=My Mac" test

echo "Finished testing on macOS, showing results"
open /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test/"$(ls /Users/dalnokyberci/Library/Developer/Xcode/DerivedData/TaskWise-auimictkaiievabtjzjsahyiafph/Logs/Test | tail -n 1)"
