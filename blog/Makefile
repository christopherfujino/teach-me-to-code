.PHONY: serve
serve: ../third_party/bin/hugo
	../third_party/bin/hugo serve --buildDrafts --buildFuture

../third_party/bin/hugo:
	# -tags are required to compile scss
	cd ../third_party/hugo ; go build -tags extended -o ../bin/ .
