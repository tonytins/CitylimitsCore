#!/bin/bash

PACKAGE="Citylimits"
OUTPUT_PATH="./docs"

dcbHelp()
{
    echo "      Welcome to DocC Build!"
    echo ""
    echo "  --static      Builds the documentation for static hosts"
    echo "  --serve       Locally hosts the documentation from your computer"
    echo "  -b --build    Builds documentation for use with xCode"
}


if [ "$1" = "--serve" ]; then
    swift package --disable-sandbox preview-documentation --target $PACKAGE
elif [ "$1" = "--static" ]; then
    swift package --allow-writing-to-directory $OUTPUT_PATH \
        generate-documentation --target $PACKAGE --output-path $OUTPUT_PATH \
        --transform-for-static-hosting --hosting-base-path $PACKAGE
elif [ "$1" = "-b" ] || [ "$1" = "--build" ]; then
    swift package generate-documentation
elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    dcbHelp
else
    dcbHelp
fi

