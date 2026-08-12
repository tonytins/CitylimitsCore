# This is mostly here to make generating docs easier.
package = Citylimits

all: build test docs

build:
	swift build

test:
	swift test -v --parallel

docs:
	swift package --allow-writing-to-directory ./docs \
    generate-documentation --target $(package) --output-path ./docs \
    --transform-for-static-hosting --hosting-base-path $(package)

preview:
	swift package --disable-sandbox preview-documentation --target $(package) --port 60339
