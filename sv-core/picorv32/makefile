formal: WriteBackChecker.sv
	@sby -f formal.sby

WriteBackChecker.sv:
	@cd ../../ && \
	 sbt "svcore/runMain svcore.Main -m writeback -c sv-core/picorv32/config.json -t sv-core/picorv32"

clean:
	-@rm -f WriteBackChecker.*
	-@rm -rf formal

.PHONY: formal clean
