package build.please.compile;

import build.please.compile.BuildRequest;
import build.please.compile.JavaCompiler;
import com.google.errorprone.ErrorProneJavaCompiler;

public class ErrorProneCompiler extends JavaCompiler {

    @Override
    public javax.tools.JavaCompiler newCompiler(BuildRequest request) {
        if (shouldCheck(request)) {
            return new ErrorProneJavaCompiler();
        }
        return super.newCompiler(request);
    }

    // shouldCheck returns true if the given request should be checked with Error Prone.
    // Currently this attempts to exclude generated code although we don't consistently
    // label it as such (but when we do one day, this will Just Work...).
    static boolean shouldCheck(BuildRequest request) {
        return !request.labels.contains("proto");
    }

    public static void main(String[] args) {
        ErrorProneCompiler compiler = new ErrorProneCompiler();
        compiler.run();
    }
}
