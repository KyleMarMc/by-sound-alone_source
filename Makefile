# Note: modified from original source from maintainer
BUILD = build
BOOKNAME = Subworldbook1
# This BOOKNAME variable is the output file name, not the title
TITLE = title.txt
METADATA = metadata.xml
# Metadata is a part of the epub standard, even if it repeats stuff in the title file
CHAPTERS = full-draft-manuscripts/manuscript_draft-subworld_book1.md
# TOC = --toc --toc-depth=2
# uncomment above line if you want a TOC; and uncomment pandoc lines below that includes TOC; comment line that doesn't
# I believe separate chapter files are just separated by a space --- see maintainer version to check
COVER_IMAGE = cover/cover-final.jpg
# I think the cover pic works better if you use a .png or a .jpg
# But upload a .tif to Amazon's cover pic
LATEX_CLASS = report
CSS = epub.css
# This corresponds to the --css switch in the epub pandoc command
# It is critically important because it centers the titles and separators among other things. It vastly improves the epub output.
# It is not included in the original maintainer's version.
# The -css switch doesn't seem to have an impact on html or pdf output.

all: book

book: epub html pdf

clean:
	rm -r $(BUILD)

epub: $(BUILD)/epub/$(BOOKNAME).epub

html: $(BUILD)/html/$(BOOKNAME).html

pdf: $(BUILD)/pdf/$(BOOKNAME).pdf

$(BUILD)/epub/$(BOOKNAME).epub: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/epub
#	pandoc $(TOC) --from markdown+smart --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^
#	above with TOC
	pandoc --css=$(CSS) --from markdown+smart --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^
	# Note: if you look at the original source from the maintainer for this ebook compiler they have a -S in these lines. That switch is deprecated in modern pandoc. I added the --from markdown+smart instead.

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
#	pandoc --from markdown+smart $(TOC) --to=html5 -o $@ $^
#	above with TOC
	pandoc --from markdown+smart --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
#	pandoc --from markdown+smart --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^
#	above with TOC
	pandoc --from markdown+smart $(TOC) --pdf-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf