#!/bin/bash
#get todays month
TODAYS_MONTH=$(date +%m)
#get current versions
VERSION_MAJOR=$(./demoApp/gradlew -p demoApp -q app:printVersionMajor | tail -n 1)
VERSION_MINOR=$(./demoApp/gradlew -p demoApp -q app:printVersionMinor | tail -n 1)

#update versions
echo "*********** current values ***********"
echo "Aspected month is: $ASPECTED_MONTH"
echo "Current month is: $TODAYS_MONTH"
echo "old VERSION_MAJOR: $VERSION_MAJOR"
echo "old VERSION_MINOR: $VERSION_MINOR"

ASPECTED_MONTH=$((x=52,y=12,z=x%y))

if [ ASPECTED_MONTH==TODAYS_MONTH ]
then
  VERSION_MINOR=$((VERSION_MINOR+1))
else
  VERSION_MAJOR=$((VERSION_MAJOR+1))
fi

echo "*********** update ***********"
echo "new VERSION_MAJOR: $VERSION_MAJOR"
echo "new VERSION_MINOR: $VERSION_MINOR"

filename="demoApp/buildsystem/config.gradle"

#write the new version on the config file
replaceMajor="        versionMajor : $VERSION_MAJOR,"
replaceMinor="        versionMinor : $VERSION_MINOR,"
sed -i '' "4s/.*/$replaceMajor/" $filename
sed -i '' "5s/.*/$replaceMinor/" $filename
