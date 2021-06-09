all: build

build: buildmo
	python3 -m pip install -r src/requirements.txt
buildmo:
	@echo "Building translation files"
	# WARNING: the second sed below will only works correctly with the languages that don't contain "-"
	for file in `ls src/locale/*.ts`; do \
		qmfile=`echo $$file | sed 's@po/@@' | sed 's/.po/.qm/'`; \
		lrelease $$file $$qmfile; \
	done \

run: build buildmo
	cd src; \
	python3 subtitld.py

uninstall:
	python3 -m pip uninstall -r src/requirements.txt
clean:
	rm -f src/locale/*.qm
