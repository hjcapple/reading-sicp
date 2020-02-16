cc = clang
opt = -O2
program = scheme
obj = scheme_runtime.o eceval_support.o eceval.o prime_libs.o scheme.o syntax.o

$(program): $(obj)
	$(cc) $(opt) -o $(program) $(obj)

scheme.o: scheme.c eceval.h eceval_support.h prime_libs.h scheme_libs.h scheme_runtime.h
	$(cc) -c $(opt) scheme.c

eceval_support.o: eceval_support.c eceval_support.h scheme_runtime.h prime_libs.h
	$(cc) -c $(opt) eceval_support.c

eceval.o: eceval.c eceval.h scheme_runtime.h syntax.h eceval_support.h
	$(cc) -c $(opt) eceval.c

prime_libs.o: prime_libs.c prime_libs.h scheme_runtime.h
	$(cc) -c $(opt) prime_libs.c

scheme_runtime.o: scheme_runtime.c scheme_runtime.h
	$(cc) -c $(opt) scheme_runtime.c

syntax.o: syntax.c syntax.h prime_libs.h scheme_runtime.h
	$(cc) -c $(opt) syntax.c

clean:
	rm -f $(obj) $(program)


