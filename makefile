package = Citylimits

all: build test docs

build:
	swift build

test:
	swift test -v --parallel
