package net.thoughtmachine.build;

import build.please.compile.JavaCompiler;
import build.please.worker.WorkerProto.BuildRequest;
import com.google.errorprone.ErrorProneJavaCompiler;

public class ErrorProneCompiler extends build.please.compile.JavaCompiler {

    @Override
    public javax.tools.JavaCompiler newCompiler(BuildRequest request) {
        // TODO(peterebden): Add an exclusion for generated proto code once we have a
        //                   principled way of identifying it. The generated code does not always
        //                   compile clean and there's no point spending time checking it anyway.
        return new ErrorProneJavaCompiler();
    }

    public static void main(String[] args) {
        ErrorProneCompiler compiler = new ErrorProneCompiler();
        compiler.run();
    }
}
