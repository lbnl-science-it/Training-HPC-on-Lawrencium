all: Training-HPC-on-Lawrencium_slides.html Training-HPC-on-Lawrencium.html

Training-HPC-on-Lawrencium.html: Training-HPC-on-Lawrencium.md
	pandoc -s -o Training-HPC-on-Lawrencium.html Training-HPC-on-Lawrencium.md

Training-HPC-on-Lawrencium_slides.html: Training-HPC-on-Lawrencium.md
	pandoc -s --webtex -t slidy -o Training-HPC-on-Lawrencium_slides.html Training-HPC-on-Lawrencium.md

clean:
	rm -rf Training-HPC-on-Lawrencium.html Training-HPC-on-Lawrencium_slides.html
