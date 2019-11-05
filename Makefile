builtfiles = build/requests.xml build/errors.xml build/content.xml

define newsetting
@read -p "$(1) [$(3)]: " thisset ; [[ -z "$$thisset" ]] && echo "$(2) $(3)" >> $(4) || echo "$(2) $$thisset" | sed 's/\/$$//g' >> $(4)
endef

define getsetting
$$(grep "^$(2)[ \t]*" $(1) | sed 's/^$(2)[ \t]*//g')
endef

define newlist
@echo "Enter $(3) hostname (alphabetic or numeric characters . -)"
@while true; do read -p "$(1): " thisval ; [[ -z "$$thisval" ]] && break ; echo "$$thisval" >> $(2) ; done
endef

define filesummary
@echo ""
@echo "################################"
@echo "# Build the following files:"
@echo "$(builtfiles)" | sed 's/ /\n/g' | while read line; do echo "#     $$line"; done
@echo "################################"
endef

all: $(builtfiles)
	$(call filesummary)
	

build/requests.xml: prebuild
	m4 -DWEBHOSTLIST="$$(awk 'BEGIN { printf("(") } /^[a-zA-Z0-9.-]+$$/ { printf("host=%s OR ",$$0) } END { printf(")") }' tmp/webhostlist.txt | sed 's/ OR )/)/g')" -DHTLOGS="$(call getsetting,tmp/settings.txt,HTLOGS)" requests.xml.m4 > build/requests.xml

build/errors.xml: prebuild
	m4 -DWEBHOSTLIST="$$(awk 'BEGIN { printf("(") } /^[a-zA-Z0-9.-]+$$/ { printf("host=%s OR ",$$0) } END { printf(")") }' tmp/pubhostlist.txt | sed 's/ OR )/)/g')" -DCRXDIR="$(call getsetting,tmp/settings.txt,CRXDIR)" errors.xml.m4 > build/errors.xml

build/content.xml: prebuild
	m4 -DPUBHOSTLIST="$$(awk 'BEGIN { printf("(") } /^[a-zA-Z0-9.-]+$$/ { printf("host=%s OR ",$$0) } END { printf(")") }' tmp/pubhostlist.txt | sed 's/ OR )/)/g')" -DWEBHOSTLIST="$$(awk 'BEGIN { printf("(") } /^[a-zA-Z0-9.-]+$$/ { printf("host=%s OR ",$$0) } END { printf(")") }' tmp/webhostlist.txt | sed 's/ OR )/)/g')" -DCRXDIR="$(call getsetting,tmp/settings.txt,CRXDIR)" -DHTLOGS="$(call getsetting,tmp/settings.txt,HTLOGS)" content.xml.m4 > build/content.xml

prebuild: tmp/settings.txt tmp/webhostlist.txt tmp/pubhostlist.txt build

tmp/settings.txt: tmp
	$(call newsetting,Enter Apache log path,HTLOGS,/var/logs/httpd,tmp/settings.txt)
	$(call newsetting,Enter crx-quickstart install path,CRXDIR,/opt/crx-quickstart,tmp/settings.txt)

tmp/webhostlist.txt: tmp
	$(call newlist,>,tmp/webhostlist.txt,web server)
	
tmp/pubhostlist.txt: tmp
	$(call newlist,>,tmp/pubhostlist.txt,publisher)

build:
	mkdir build

tmp:
	mkdir tmp

clean:
	rm -rf tmp
	rm -rf build
