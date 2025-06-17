.PHONY: serve
serve: ../third_party/bin/hugo
	../third_party/bin/hugo serve --buildDrafts --buildFuture

../third_party/bin/hugo:
	# -tags extended is required to compile scss
	cd ../third_party/hugo ; go build -tags extended -o ../bin/ .

.PHONY: preview
preview:
	ls content/posts | \
		sed 's/\.md$\//' | \
		sort --reverse | \
		fzf --no-sort | \
		awk '{printf "http://localhost:1313/posts/%s\n",$$1}' | \
		xargs links -dump
