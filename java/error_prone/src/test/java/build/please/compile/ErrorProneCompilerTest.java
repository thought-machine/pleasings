package build.please.compile;

import build.please.compile.BuildRequest;
import org.junit.Test;
import java.util.Arrays;
import java.util.ArrayList;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;


public class ErrorProneCompilerTest {
    @Test
    public void testContainsDefault() {
        assertTrue(ErrorProneCompiler.shouldCheck(new BuildRequest()));
    }

    @Test
    public void testContainsProto() {
        BuildRequest request = new BuildRequest();
        request.labels = new ArrayList<>(Arrays.asList("proto"));
        assertFalse(ErrorProneCompiler.shouldCheck(request));
    }
}
