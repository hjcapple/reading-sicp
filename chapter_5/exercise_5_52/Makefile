cc = clang
dir = ../exercise_5_51
opt = -O2 -I ../exercise_5_51/
program = scheme
obj = scheme_runtime.o eceval_support.o prime_libs.o scheme.o

$(program): $(obj)
	$(cc) $(opt) -o $(program) $(obj)

scheme.o: scheme.c gen-scheme.hpp $(dir)/eceval_support.h $(dir)/prime_libs.h $(dir)/scheme_runtime.h
	$(cc) -c $(opt) scheme.c

eceval_support.o: $(dir)/eceval_support.c $(dir)/eceval_support.h $(dir)/scheme_runtime.h $(dir)/prime_libs.h
	$(cc) -c $(opt) $(dir)/eceval_support.c

prime_libs.o: $(dir)/prime_libs.c $(dir)/prime_libs.h $(dir)/scheme_runtime.h
	$(cc) -c $(opt) $(dir)/prime_libs.c

scheme_runtime.o: $(dir)/scheme_runtime.c $(dir)/scheme_runtime.h
	$(cc) -c $(opt) $(dir)/scheme_runtime.c

clean:
	rm -f $(obj) $(program)

