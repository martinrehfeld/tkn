generated_release?=demo
deployed_release?=demo_deployed
previous_release?=demo_deployed

all: compile

compile:
	./rebar compile

rel/$(generated_release)/: compile
	cd rel && rm -rf $(generated_release) && ../rebar generate

release: rel/$(generated_release)/

rel/$(deployed_release)/: release
	cd rel && rm -rf $(deployed_release) && mv demo demo_deployed

deploy: rel/$(deployed_release)/

generate_appup: release
	cd rel && ../rebar generate-appups previous_release=$(previous_release)

generate_upgrade:
	cd rel && ../rebar generate-upgrade previous_release=$(previous_release)

deploy_upgrade:
	cd rel && mv $(generated_release)_*.tar.gz $(deployed_release)/releases

fix_nodetool:
	@cd rel && cp files/nodetool $(deployed_release)/erts-*/bin

upgrade: generate_appup generate_upgrade deploy_upgrade

demo:
	./rel/$(deployed_release)/bin/demo console

console: fix_nodetool
	./rel/$(deployed_release)/bin/demo remote_console
