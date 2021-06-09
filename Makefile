all: build

build: buildmo
	sudo python3 -m pip install -r src/requirements.txt
buildmo:
	@echo "Building translation files"
	# WARNING: the second sed below will only works correctly with the languages that don't contain "-"
	for file in `ls src/locale/*.ts`; do \
		qmfile=`echo $$file | sed 's@po/@@' | sed 's/.po/.qm/'`; \
		lrelease $$file $$qmfile; \
	done \

run:
	cd src; \
	python3 subtitld.py

uninstall:
	sudo python3 -m pip uninstall -r src/requirements.txt
clean:
	rm -f src/locale/*.qm
