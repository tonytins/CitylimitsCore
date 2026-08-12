#!/bin/bash

PACKAGE="Citylimits"

if [ "$1" = "--serve" ]; then
    swift package --disable-sandbox preview-documentation --target $PACKAGE
elif [ "$1" = "--static" ]; then
    swift package --allow-writing-to-directory ./docs \
        generate-documentation --target $PACKAGE --output-path ./docs \
        --transform-for-static-hosting --hosting-base-path $PACKAGE
elif [ "$1" = "-b" ] || [ "$1" = "--build" ]; then
    swift package generate-documentation
else
    echo "      Welcome to DocC Build!"
    echo ""
    echo "  --static      Builds a static HTML file"
    echo "  --serve       Host the documentation on your local computer"
    echo "  -b --build    Builds documentation for use with xCode"
fi

