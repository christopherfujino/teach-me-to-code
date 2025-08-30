package main

import (
	"fmt"
	"strings"

	goldmark "github.com/yuin/goldmark"
	"github.com/yuin/goldmark/ast"
	"github.com/yuin/goldmark/text"
)

var sourceBuffer = []byte(`# H1
P1

P2
continuation

### H3

[P3](http://www.com).










P4`)

func main() {
	buffer := strings.Builder{}
	reader := text.NewReader(sourceBuffer)
	// no-op
	rawRoot := goldmark.DefaultParser().Parse(reader)
	mapTree(&buffer, rawRoot)
	fmt.Println(buffer.String())
}

func mapTree(buffer *strings.Builder, root ast.Node) {
	switch root.Kind().String() {
	case "Document":
		// TODO?
	case "Heading":
		cur := (root).(*ast.Heading)
		for range cur.Level {
			buffer.WriteString("#")
			buffer.WriteString("#")
		}
		buffer.WriteString(" ")
	case "Text":
		cur := (root).(*ast.Text)
		buffer.WriteString(string(cur.Value(sourceBuffer)))
		buffer.WriteString(" ")
	case "Paragraph":
		buffer.WriteString("\n")
	case "Link":
		cur := (root).(*ast.Link)
		buffer.WriteString("[")
		mapTree(buffer, cur.FirstChild())
		buffer.WriteString(fmt.Sprintf("](%s)", string(cur.Destination)))
	default:
		panic(root.Kind().String())
	}
	currentChild := root.FirstChild()
	for range root.ChildCount() {
		mapTree(buffer, currentChild)
		currentChild = currentChild.NextSibling()
	}
}
