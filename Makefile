

MATLAB_DIR=~/MATLAB/R2013a_Student/

MATLAB=$(MATLAB_DIR)/bin/matlab
MEX=$(MATLAB_DIR)/bin/mex
OUT_DIR=out


BINARIES=hexdiff.mexa64

all: $(BINARIES) gen_models run_models $(OUT_DIR)/report.html

clean:
	rm -fr $(BINARIES)
	rm -fr $(OUT_DIR)

#gen_vars:
#	mkdir -p $(OUT_DIR)
#	./generate_variables.sh $(OUT_DIR)

gen_models:
	mkdir -p $(OUT_DIR)
	./generate_models.sh $(OUT_DIR)

run_models: gen_models
	+make do_run_models

do_run_models:  $(basename $(wildcard $(OUT_DIR)/*.m))

$(OUT_DIR)/report.html: gen_models
	cat $(OUT_DIR)/model_*.html >> $@

# Build a mex library
%.mexa64: %.c
	$(MEX) $<


# Run a model
$(OUT_DIR)/%: $(OUT_DIR)/%.m
	@ echo "Generating $@ from $<"
	cd $(OUT_DIR) ; $(MATLAB) -nodesktop -r "$(notdir $@); quit;"
	./gen_video.sh $@/video
	cat $(OUT_DIR)/model_*.css > $(OUT_DIR)/tables.css

