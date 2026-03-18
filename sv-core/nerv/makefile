formal: WriteBackChecker.sv
	@sby -f formal.sby

WriteBackChecker.sv: config.json
	@cd ../../ && \
	 sbt "svcore/runMain svcore.Main -m writeback -c sv-core/nerv/config.json -t sv-core/nerv"
	@rm -f WriteBackChecker.fir WriteBackChecker.anno.json

assume:
	@cd ../../ && \
	 sbt "svcore/runMain svcore.Main -m assume -c sv-core/nerv/config.json -t sv-core/nerv"
	@rm -f firrtl_black_box_resource_files.f InstAssume.fir InstAssume.anno.json

clean:
	-@rm -f firrtl_black_box_resource_files.f *.fir *.anno.json WriteBackChecker.sv
	-@rm -rf formal

.PHONY: formal assume clean
