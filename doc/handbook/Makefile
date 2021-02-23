LATEXC=pdflatex --shell-escape

all: pcraft-handbook

pcraft-handbook: pcraft-handbook.tex
	${LATEXC} pcraft-handbook.tex

clean:
	rm -f pcraft-handbook.aux
	rm -f pcraft-handbook.log
	rm -f pcraft-handbook.pdf
	rm -f pcraft-handbook.out
	rm -f pcraft-handbook-pics.pdf
	rm -f *~
