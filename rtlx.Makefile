CSS_FILES = $(shell find "$(TARGET_PATH)" -type f -name "*.css" -not -name "*-rtl.css" -not -name "*-rtlx.css" -not -path "*/files/*")
RTLX_CSS_FILES = $(patsubst %.css, %-rtlx.css, $(CSS_FILES))
RTLX_IMG_FILES = $(shell find "$(TARGET_PATH)" -type f '(' -name "*.jpg" -or -name "*.jpeg" -or -name "*.png" -or -name "*.gif" ')'  -not -name "*-rtlx\.*" -not -path "*/files/*" | sed -e 's/\(.*\)\(\.[^\.]*\)/\1-rtlx\2/')

.PHONY: all

all: css images

css: $(RTLX_CSS_FILES)

images: $(RTLX_IMG_FILES)

%-rtlx.css: %.css
	cat "$<" | python "$(CSSJANUS)" > "$@"

%-rtlx.jpg: %.jpg
	gm convert -flop "$<" "$@"

%-rtlx.jpeg: %.jpeg
	gm convert -flop "$<" "$@"

%-rtlx.png: %.png
	gm convert -flop "$<" "$@"

%-rtlx.gif: %.gif
	gm convert -flop "$<" "$@"

clean:
	rm "$(RTLX_CSS_FILES)"
	rm "$(RTLX_IMG_FILES)"
